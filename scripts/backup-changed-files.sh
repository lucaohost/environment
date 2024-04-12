#!/bin/bash

# Define source directory
source_directory=$(pwd)  # Assumes the script is run from the root of the Git repository

# Define destination directory
backup_parent_directory="$(cd $LUCAO_ENV && cd .. && pwd)/backups"

# Get the name of the current folder
current_folder=$(basename "$source_directory")

# Create a folder with the current datetime and current folder name inside the backup directory
datetime=$(date +"%Y-%m-%d_%H-%M-%S")
destination_directory="$backup_parent_directory/${current_folder}_${datetime}"
mkdir -p "$destination_directory"

# Get the current directory
current_dir=$(pwd)

git reset
# Get changed files with full paths
changed_files=$(git status --porcelain | awk '$1 ~ /^[MARCU]/ || $1 == "R" {print "'"$current_dir"'" "/" $2}')

# Get untracked files with full paths
untracked_files=$(git status --porcelain | awk '$1 == "??" {print "'"$current_dir"'" "/" $2}')

# Check if there are any changes
if [ -z "$changed_files" ] && [ -z "$untracked_files" ]; then
    echo "No changes to copy."
    exit 0
fi

# Copy changed files to the destination directory
for file in $changed_files; do
    if [ -f "$file" ]; then
        cp "$file" "$destination_directory"
        echo "Copied file: $file"
    elif [ -d "$file" ]; then
        cp -r "$file" "$destination_directory"
        echo "Copied directory: $file"
    fi
done

# Copy untracked files to the destination directory
for file in $untracked_files; do
    if [ -f "$file" ]; then
        cp "$file" "$destination_directory"
        echo "Copied file: $file"
    elif [ -d "$file" ]; then
        cp -r "$file" "$destination_directory"
        echo "Copied directory: $file"
    fi
done

echo "Local Backup Process Completed in '$backup_parent_directory'"

cd $backup_parent_directory

if [ -d ".git" ]; then
    git add -A
    git commit -m "backup"
    git push
fi

# Back to the directory alias was called
cd $source_directory
