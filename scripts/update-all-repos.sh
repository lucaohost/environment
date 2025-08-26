repos_updated=0
branches_updated=0
repos_with_multiple=()

update_repo() {
    cd "$1" || return
    if [ -d ".git" ]; then
        echo "Updating repository in $(pwd)"
        branch_before_script=$(git branch --show-current)
        git fetch --all --prune
        echo "*************************"

        repo_branches_updated=0
        updated_branches=()

        # Try to update main or master
        for main_branch in main master; do
            if git show-ref --quiet refs/heads/$main_branch; then
                git checkout "$main_branch" >/dev/null 2>&1
                if git pull; then
                    echo "Updated $main_branch branch"
                    branches_updated=$((branches_updated + 1))
                    repo_branches_updated=$((repo_branches_updated + 1))
                    updated_branches+=("$main_branch")
                fi
                echo "*************************"
                break
            fi
        done

        # Remove local branches without remote reference
        git branch -vv | grep ': gone]' | awk '{print $1}' | xargs -r git branch -D

        # Get branches by author
        branches=$(git for-each-ref --format='%(refname:short) %(authorname) %(authoremail)' refs/heads/ | \
            grep -E "$PROFESSIONAL_EMAIL|$PERSONAL_EMAIL" | awk '{print $1}')

        for branch in $branches; do
            if [[ "$branch" != "main" && "$branch" != "master" ]]; then
                git checkout "$branch" >/dev/null 2>&1
                if git pull; then
                    echo "Updated branch: $branch"
                    branches_updated=$((branches_updated + 1))
                    repo_branches_updated=$((repo_branches_updated + 1))
                    updated_branches+=("$branch")
                fi
                echo "*************************"
            fi
        done

        if [ "$repo_branches_updated" -gt 0 ]; then
            repos_updated=$((repos_updated + 1))
        fi

        # Save repo if multiple branches were updated
        if [ "$repo_branches_updated" -gt 1 ]; then
            repos_with_multiple+=("$(pwd):${updated_branches[*]}")
        fi

        git checkout "$branch_before_script" >/dev/null 2>&1
        echo "==============================================="
    fi
    cd ..
}

uar() {
    folder_before_script=$(pwd)
    start_time=$(date +%s)
    echo "Starting UAR script: $(date +"%Y-%m-%d %H:%M:%S")"
    echo "==============================================="
    
    cd "$HOME/git" || exit 1
    
    for dir in */; do
        if [ -d "$dir" ]; then
            update_repo "$dir"
        fi
    done
    
    update_repo "notes/my-notes"
    cd ..
    update_repo "notes/private-code-notes"
    cd "$folder_before_script" || exit 1
    
    end_time=$(date +%s)
    elapsed=$(( end_time - start_time ))
    minutes=$(( elapsed / 60 ))
    seconds=$(( elapsed % 60 ))

    echo "UAR script finished at: $(date +"%Y-%m-%d %H:%M:%S")"
    echo "Elapsed time: ${minutes}m ${seconds}s"
    echo "Repositories updated: $repos_updated"
    echo "Branches updated: $branches_updated"

    if [ ${#repos_with_multiple[@]} -gt 0 ]; then
        echo ""
        echo "⚠️  Repositories with multiple personal branches:"
        for entry in "${repos_with_multiple[@]}"; do
            repo_path="${entry%%:*}"
            branches="${entry#*:}"
            echo " - $repo_path"
            for b in $branches; do
                echo "    • $b"
            done
        done
        echo "⚠️  Verify if there is old branches to delete."
    fi
}
