gu() {
    local commit_msg=""
    for param in "$@"; do
        commit_msg="$commit_msg$param "
    done
    commit_msg="${commit_msg%?}" # Remove last white space
    git add -A
    git commit -m "$(printf "%b" "$commit_msg")"  # Interpreta o \n como nova linha
    git push --set-upstream origin $(git rev-parse --abbrev-ref HEAD)
    commit_info=$(git log --author="lucas.reginatto@ifood.com.br" --pretty=format:"%h|%ae|%ad|$(git symbolic-ref --short HEAD)|%s|$(basename $(git rev-parse --show-toplevel))" --abbrev=8 --date=iso -n 1)
    echo $commit_info >> $HOME/git/git-work-commits/git-work-commits.txt
    current_dir=$(pwd)
    cd $HOME/git/git-work-commits/
    git config --global user.email "lucas.reginatto.de.lima@gmail.com"
    git add -A
    git commit -m "$(printf "%b" "$commit_msg")"  # Interpreta o \n como nova linha
    git push
    cd $current_dir
    git config --global user.email "lucas.reginatto@ifood.com.br"
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
        commit_msg="Manage files: $file_list\n- This commit message was automatically generated using guu alias."
    else
        local file_list=""
        for file in $modified_files; do
            file_list="$file_list$(basename "$file")\n"
        done
        commit_msg="Manage several files\n- Full list of files:\n$file_list- This commit message was automatically generated using guu alias."
    fi

    gu "$commit_msg"
}
