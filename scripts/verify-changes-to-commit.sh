verify_repo() {
    cd "$1"
     # Check if the directory is a git repository
    if [ -d ".git" ]; then
        echo "Verifying changes in repository $(pwd)"
        git status
        echo "==============================================="
    fi
    cd ..
}

vcc() {
    folder_before_script=$(pwd)
    echo "==============================================="
    # Change to the directory with all GitHub Projects
    cd $HOME/git
    # Loop through all subdirectories
    for dir in */; do
    if [ -d "$dir" ]; then
        verify_repo "$dir"
    fi
    done
    verify_repo "notes/my-notes"
    cd ..
    verify_repo "notes/private-code-notes"
    cd $folder_before_script
}
