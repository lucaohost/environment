#!/bin/bash

function gpv() {
    # Count modified files BEFORE adding them (to determine version bump)
    modified_files=$(git status --porcelain | wc -l)

    # Get the last commit message
    last_commit=$(git log -1 --pretty=%B)

    # Extract semantic versions from the last commit message (looking for v{major}.{minor}.{patch})
    versions=$(echo "$last_commit" | grep -o 'v[0-9]\+\.[0-9]\+\.[0-9]\+' | sed 's/v//' | sort -V)

    # Parse the latest version
    if [ -n "$versions" ]; then
        latest_version=$(echo "$versions" | tail -1)
        IFS='.' read -r major minor patch <<< "$latest_version"
    else
        # If no semantic version found, start with v1.0.0
        major=1
        minor=0
        patch=0
    fi

    # Determine version bump based on modified files count
    # x = 3 modified files: patch version (1.0.0 → 1.0.1)
    # y = 10 modified files: minor version (1.0.0 → 1.1.0)
    # y+ = 11+ modified files: major version (1.0.0 → 2.0.0)
    if [ "$modified_files" -le 3 ]; then
        # Patch version bump (small changes)
        patch=$((patch + 1))
    elif [ "$modified_files" -le 10 ]; then
        # Minor version bump (medium changes)
        minor=$((minor + 1))
        patch=0
    else
        # Major version bump (large changes)
        major=$((major + 1))
        minor=0
        patch=0
    fi

    # Add all modifications
    git add -A

    # Commit with the new semantic version
    git commit -m "feat: Release v$major.$minor.$patch"

    gpu
}