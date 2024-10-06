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

gul() {
    if hostname | grep -qi "work_laptop_name"; then
        echo "gul should not be used at work, only for private side projects."
        return
    fi

    local modified_files
    modified_files=$(git diff --name-only)

    local file_count=$(echo "$modified_files" | wc -l)

    if [ "$file_count" -eq 0 ]; then
        echo "No files modified."
        return
    fi

    if [ "$file_count" -le 3 ]; then
        local file_list=$(echo "$modified_files" | tr '\n' ', ' | sed 's/, $//')
        commit_msg="Manage files: $file_list\n- This commit message was automatically generated"
    else
        commit_msg="Manage several files:\n- Full list of files:\n$modified_files\n- This commit message was automatically generated"
    fi

    gu "$commit_msg"
}