#!/bin/bash

review() {

    if [ "$1" = "finish" ]; then
        # Clean all changes
        echo "Cleaning all uncommitted changes..."
        git merge --abort 2>/dev/null

        # Switch back to main branch first so we aren't "on" a branch we want to delete
        echo "Switching back to main branch..."
        git checkout main

        # Find and delete all branches starting with review-
        REVIEW_BRANCHES=$(git branch --list 'review-*' | sed 's/*//g')

        if [ -n "$REVIEW_BRANCHES" ]; then
            echo "Deleting all review branches..."
            # Using -D to force delete even if not merged
            echo "$REVIEW_BRANCHES" | xargs git branch -D
        else
            echo "No review branches found to delete."
        fi

        echo "Review cleanup finished."
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