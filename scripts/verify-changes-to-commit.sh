verify_repo() {
    cd "$1" || return
    local verified=0
    local has_changes=0

    if [ -d ".git" ]; then
        verified=1
        if ! git diff --quiet || ! git diff --cached --quiet; then
            has_changes=1
            repo_name=$(basename "$(pwd)")
            echo ""
            echo "=================================================="
            echo "📂 Repository: $repo_name"
            echo "   Path: $(pwd)"
            echo "--------------------------------------------------"
            echo "🔴 Uncommitted changes:"
            git status -s
            echo "=================================================="
        fi
    fi

    cd - >/dev/null || return

    # return code with 2 bits: 
    #   1 = verified, 2 = has_changes
    return $((verified + has_changes * 2))
}

vcc() {
    folder_before_script=$(pwd)
    repos_verified=0
    repos_with_changes=0

    echo ""
    echo "🔍 Verifying Changes to Commit:"

    cd "$HOME/git" || return

    for dir in */; do
        if [ -d "$dir" ]; then
            verify_repo "$dir"
            result=$?
            if (( result & 1 )); then
                repos_verified=$((repos_verified + 1))
            fi
            if (( result & 2 )); then
                repos_with_changes=$((repos_with_changes + 1))
            fi
        fi
    done

    verify_repo "notes/my-notes"
    result=$?
    if (( result & 1 )); then
        repos_verified=$((repos_verified + 1))
    fi
    if (( result & 2 )); then
        repos_with_changes=$((repos_with_changes + 1))
    fi

    verify_repo "notes/private-code-notes"
    result=$?
    if (( result & 1 )); then
        repos_verified=$((repos_verified + 1))
    fi
    if (( result & 2 )); then
        repos_with_changes=$((repos_with_changes + 1))
    fi

    cd "$folder_before_script" || return
    echo ""
    echo "✅ Verification complete!"
    echo "📊 Total repositories verified: $repos_verified"
    echo "✏️  Repositories with changes: $repos_with_changes"
    echo ""
}
