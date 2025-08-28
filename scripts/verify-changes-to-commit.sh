verify_repo() {
    cd "$1" || return
    local verified=0

    if [ -d ".git" ]; then
        verified=1
        if ! git diff --quiet || ! git diff --cached --quiet; then
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
    return $verified
}

vcc() {
    folder_before_script=$(pwd)
    repos_verified=0

    echo ""
    echo "🔍 Verifying Changes to Commit:"

    cd "$HOME/git" || return

    for dir in */; do
        if [ -d "$dir" ]; then
            verify_repo "$dir"
            repos_verified=$((repos_verified + $?))
        fi
    done

    verify_repo "notes/my-notes"
    repos_verified=$((repos_verified + $?))

    verify_repo "notes/private-code-notes"
    repos_verified=$((repos_verified + $?))

    cd "$folder_before_script" || return
    echo ""
    echo "✅ Verification complete!"
    echo "📊 Total repositories verified: $repos_verified"
    echo ""
}
