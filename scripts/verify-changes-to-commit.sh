#!/bin/bash
echo "==============================================="
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

# Change to the directory with all GitHub Projects
cd $LUCAO_ENV && cd ..
# Loop through all subdirectories
for dir in */; do
    if [ -d "$dir" ]; then
        verify_repo "$dir"
    fi
done