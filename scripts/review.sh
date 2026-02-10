#!/bin/bash

review() {

    if [ "$1" = "finish" ]; then
        # Clean all changes
        echo "Cleaning all uncommitted changes..."
        git merge --abort

        # Switch back to main branch
        echo "Switching back to main branch..."
        git checkout main

        # Get current review branch and delete it
        CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
        if [[ "$CURRENT_BRANCH" == review-* ]]; then
            echo "Deleting review branch: $CURRENT_BRANCH"
            git branch -D "$CURRENT_BRANCH"
        fi

        echo "Review finished. Changes discarded and review branch deleted."
    else
        REMOTE_BRANCH="$1"
        REVIEW_BRANCH="review-${REMOTE_BRANCH}"

        # Fetch the latest changes from remote
        echo "Fetching latest changes from remote..."
        git fetch origin

        # Switch to review branch (create if it doesn't exist)
        echo "Switching to review branch: $REVIEW_BRANCH"
        git checkout -B "$REVIEW_BRANCH" origin/main

        # Merge without committing
        echo "Merging $REMOTE_BRANCH into review branch..."
        git merge --no-commit --no-ff "origin/${REMOTE_BRANCH}"

        # Review the changes
        echo ""
        echo "=== Git Status ==="
        git status
        echo ""
        echo "=== Staged Changes ==="
    fi
}