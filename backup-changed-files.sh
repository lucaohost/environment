#!/bin/bash

# Define source directory
source_directory=$(pwd)  # Assumes the script is run from the root of the Git repository

# Define destination directory
backup_parent_directory="$HOME/Documents/BackupCodes"

# Get the name of the current folder
current_folder=$(basename "$source_directory")

# Create a folder with the current datetime and current folder name inside the backup directory
datetime=$(date +"%Y-%m-%d_%H-%M-%S")
destination_directory="$backup_parent_directory/${current_folder}_${datetime}"
mkdir -p "$destination_directory"

# Get the list of modified and untracked files from git status
changed_files=$(git status --porcelain | awk '$1 ~ /^[MARCDU]/ {print $2}')
untracked_files=$(git status --porcelain | awk '$1 == "??" {print $2}')

# Check if there are any changes
if [ -z "$changed_files" ] && [ -z "$untracked_files" ]; then
    echo "No changes to copy."
    exit 0
fi

# Copy changed files to the destination directory
for file in $changed_files; do
    cp "$source_directory/$file" "$destination_directory"
    echo "Copied: $file"
done

# Copy untracked files to the destination directory
for file in $untracked_files; do
    cp "$source_directory/$file" "$destination_directory"
    echo "Copied: $file"
done

echo "Local Backup Process Completed in $HOME/Documents/BackupCodes/$destination_directory"
