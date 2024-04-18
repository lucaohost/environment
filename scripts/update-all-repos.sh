update_repo() {
    cd "$1"
     # Check if the directory is a git repository
    if [ -d ".git" ]; then
        echo "Updating repository in $(pwd)"
        git pull
        echo "==============================================="
    fi
    cd ..
}

uar() {
    echo "==============================================="
    # Change to the directory with all GitHub Projects
    cd $LUCAO_ENV && cd ..
    # Loop through all subdirectories
    for dir in */; do
        if [ -d "$dir" ]; then
            update_repo "$dir"
        fi
    done
}
