#!/bin/bash

review() {

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
}