#!/bin/bash

repos_updated=0
branches_updated=0
repos_with_multiple=()

# Colors
GREEN="\033[0;32m"
RED="\033[0;31m"
YELLOW="\033[1;33m"
CYAN="\033[0;36m"
BOLD="\033[1m"
RESET="\033[0m"

progress_bar() {
    local current=$1
    local total=$2
    local width=40
    local percent=$(( current * 100 / total ))
    local filled=$(( width * current / total ))
    local empty=$(( width - filled ))

    # Draw progress bar
    printf "\r["
    for ((i=0; i<filled; i++)); do printf "█"; done
    for ((i=0; i<empty; i++)); do printf " "; done
    printf "] %3d%% (%d/%d)" "$percent" "$current" "$total"
}

update_repo() {
    cd "$1" || return
    if [ -d ".git" ]; then
        echo -e "\n${CYAN}🔄 Repository: ${BOLD}$(basename "$(pwd)")${RESET}"
        branch_before_script=$(git branch --show-current)
        git fetch --all --prune >/dev/null 2>&1

        repo_branches_updated=0
        updated_branches=()

        # Try to update main or master
        for main_branch in main master; do
            if git show-ref --quiet refs/heads/$main_branch; then
                git checkout "$main_branch" >/dev/null 2>&1
                if git pull --ff-only; then
                    echo -e "   ✅ Updated ${GREEN}$main_branch${RESET}"
                    branches_updated=$((branches_updated + 1))
                    repo_branches_updated=$((repo_branches_updated + 1))
                    updated_branches+=("$main_branch")
                fi
                break
            fi
        done

        # Remove local branches without remote reference
        git branch -vv | grep ': gone]' | awk '{print $1}' | xargs -r git branch -D >/dev/null 2>&1

        # Get personal/professional branches
        branches=$(git for-each-ref --format='%(refname:short) %(authorname) %(authoremail)' refs/heads/ | \
            grep -E "$PROFESSIONAL_EMAIL|$PERSONAL_EMAIL" | awk '{print $1}')

        for branch in $branches; do
            if [[ "$branch" != "main" && "$branch" != "master" ]]; then
                git checkout "$branch" >/dev/null 2>&1
                if git pull --ff-only; then
                    echo -e "   ✅ Updated ${GREEN}$branch${RESET}"
                    branches_updated=$((branches_updated + 1))
                    repo_branches_updated=$((repo_branches_updated + 1))
                    updated_branches+=("$branch")
                fi
            fi
        done

        if [ "$repo_branches_updated" -gt 0 ]; then
            repos_updated=$((repos_updated + 1))
        fi

        if [ "$repo_branches_updated" -gt 1 ]; then
            repos_with_multiple+=("$(pwd):${updated_branches[*]}")
        fi

        git checkout "$branch_before_script" >/dev/null 2>&1
    fi
    cd ..
}

uar() {
    folder_before_script=$(pwd)
    start_time=$(date +%s)
    echo -e "${BOLD}🚀 Starting UAR script at $(date +"%Y-%m-%d %H:%M:%S")${RESET}"

    cd "$HOME/git" || exit 1
    
    # Collect all repos first
    repos=(*/)
    repos+=("notes/my-notes" "notes/private-code-notes")
    total_repos=${#repos[@]}
    current_repo=0

    for dir in "${repos[@]}"; do
        if [ -d "$dir" ]; then
            update_repo "$dir"
        fi
        current_repo=$((current_repo + 1))
        progress_bar "$current_repo" "$total_repos"
    done

    cd "$folder_before_script" || exit 1

    end_time=$(date +%s)
    elapsed=$(( end_time - start_time ))
    minutes=$(( elapsed / 60 ))
    seconds=$(( elapsed % 60 ))

    echo -e "\n\n${BOLD}📊 Summary:${RESET}"
    echo -e "   ⏱  Elapsed time: ${minutes}m ${seconds}s"
    echo -e "   📂 Repositories updated: ${GREEN}$repos_updated${RESET}"
    echo -e "   🌿 Branches updated: ${GREEN}$branches_updated${RESET}"

    if [ ${#repos_with_multiple[@]} -gt 0 ]; then
        echo -e "\n${YELLOW}⚠️  Repositories with multiple updated branches:${RESET}"
        for entry in "${repos_with_multiple[@]}"; do
            repo_path="${entry%%:*}"
            branches="${entry#*:}"
            echo " - $(basename "$repo_path")"
            for b in $branches; do
                echo "    • $b"
            done
        done
        echo -e "${YELLOW}⚠️  Consider cleaning up old branches.${RESET}"
    fi

    echo -e "\n${BOLD}✅ UAR script finished at $(date +"%Y-%m-%d %H:%M:%S")${RESET}"
}
