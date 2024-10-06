gu() {
    local commit_msg=""
    for param in "$@"; do
        commit_msg="$commit_msg$param "
    done
    commit_msg="${commit_msg%?}"
    git add -A
    git commit -m "$commit_msg"
    git push --set-upstream origin $(git rev-parse --abbrev-ref HEAD)
    echo "$commit_msg"
}

guu() {
    if hostname | grep -qi "work_laptop_name"; then
        echo "guu should not be used at work, only for personal side projects."
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
        local file_list=""
        for file in $modified_files; do
            file_list="$file_list$(basename "$file"), "
        done
        file_list="${file_list%, }" # Remove last comma and space
        commit_msg="Manage files: $file_list\n- This commit message was automatically generated"
    else
        local file_list=""
        for file in $modified_files; do
            file_list="$file_list$(basename "$file")\n"
        done
        commit_msg="Manage several files\n- Full list of files:\n$file_list- This commit message was automatically generated"
    fi
    
    gu "$(printf "%b" "$commit_msg")"
}
