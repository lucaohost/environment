update_repo() {
    cd "$1"
    # Check if the directory is a git repository
    if [ -d ".git" ]; then
        echo "Updating repository in $(pwd)"
        branch_before_script=$(git branch --show-current)
        git fetch --all
        branches=$(git branch --format='%(refname:short)')
        for branch in $branches; do
            git checkout "$branch"
            git pull
            echo "*************************"
        done
	echo "Returning to branch before script"
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
