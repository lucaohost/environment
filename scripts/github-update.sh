gu() {
    local commit_msg=""
    for param in "$@"; do
        commit_msg="$commit_msg$param "
    done
    commit_msg="${commit_msg%?}" #remove last white space
    git add -A
    git commit -m "$commit_msg"
    git push --set-upstream origin $(git rev-parse --abbrev-ref HEAD)
    echo "$commit_msg"
}