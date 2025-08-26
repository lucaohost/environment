repos_updated=0
branches_updated=0

update_repo() {
    cd "$1" || return
    # Check if the directory is a git repository
    if [ -d ".git" ]; then
        echo "Updating repository in $(pwd)"
        branch_before_script=$(git branch --show-current)
        git fetch --all --prune
        echo "*************************"

        repo_branches_updated=0

        # Always update main or master branch first
        if git show-ref --quiet refs/heads/main; then
            git checkout main
            if git pull; then
                echo "Updated main branch"
                branches_updated=$((branches_updated + 1))
                repo_branches_updated=$((repo_branches_updated + 1))
            fi
            echo "*************************"
        elif git show-ref --quiet refs/heads/master; then
            git checkout master
            if git pull; then
                echo "Updated master branch"
                branches_updated=$((branches_updated + 1))
                repo_branches_updated=$((repo_branches_updated + 1))
            fi
            echo "*************************"
        fi

        # Remove local branches without remote reference
        git branch -vv | grep ': gone]' | awk '{print $1}' | xargs -r git branch -D

        # Get branches created by the specified authors
        branches=$(git for-each-ref --format='%(refname:short) %(authorname) %(authoremail)' refs/heads/ | \
        grep -E "$PROFESSIONAL_EMAIL|$PERSONAL_EMAIL" | awk '{print $1}')

        for branch in $branches; do
            # Avoid re-pulling main or master if already updated
            if [[ "$branch" != "main" && "$branch" != "master" ]]; then
                git checkout "$branch"
                if git pull; then
                    echo "Updated branch: $branch"
                    branches_updated=$((branches_updated + 1))
                    repo_branches_updated=$((repo_branches_updated + 1))
                fi
                echo "*************************"
            fi
        done

        if [ "$repo_branches_updated" -gt 0 ]; then
            repos_updated=$((repos_updated + 1))
        fi

        echo "Returning to original branch before script"
        git checkout "$branch_before_script"
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
    
    echo "==============================================="
    echo "UAR script finished at: $(date +"%Y-%m-%d %H:%M:%S")"
    echo "Elapsed time: ${minutes}m ${seconds}s"
    echo "Repositories updated: $repos_updated"
    echo "Branches updated: $branches_updated"
}
