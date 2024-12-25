update_repo() {
    cd "$1"
    # Check if the directory is a git repository
    if [ -d ".git" ]; then
        echo "Updating repository in $(pwd)"
        branch_before_script=$(git branch --show-current)
        git fetch --all
        echo "*************************"

        # Always update main or master branch first
        if git show-ref --quiet refs/heads/main; then
            git checkout main
            git pull
            echo "Updated main branch"
            echo "*************************"
        elif git show-ref --quiet refs/heads/master; then
            git checkout master
            git pull
            echo "Updated master branch"
            echo "*************************"
        fi

        # Get branches created by the specified authors
        branches=$(git for-each-ref --format='%(refname:short) %(authorname) %(authoremail)' refs/heads/ | \
        grep -E "$PROFESSIONAL_EMAIL|$PERSONAL_EMAIL" | awk '{print $1}')

        for branch in $branches; do
            # Avoid re-pulling main or master if already updated
            if [[ "$branch" != "main" && "$branch" != "master" ]]; then
                git checkout "$branch"
                git pull
                echo "*************************"
            fi
        done

        echo "Returning to original branch before script"
        git checkout "$branch_before_script"
        echo "==============================================="
    fi
    cd ..
}

uar() {
    folder_before_script=$(pwd)
    echo "==============================================="
    # Change to the directory with all GitHub Projects
    cd $LUCAO_ENV && cd ..
    # Loop through all subdirectories
    for dir in */; do
        if [ -d "$dir" ]; then
            update_repo "$dir"
        fi
    done
    cd $folder_before_script
}
