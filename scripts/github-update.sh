gu() {
    local commit_msg=""
    for param in "$@"; do
        commit_msg="$commit_msg$param "
    done
    commit_msg="${commit_msg%?}" # Remove last white space
    git add -A
    git commit -m "$(printf "%b" "$commit_msg")"  # Interpreta o \n como nova linha
    git push --set-upstream origin $(git rev-parse --abbrev-ref HEAD)
    if [ $(hostname) != "LucaS" ]; then
        update_git_work_commits "$commit_msg"
    fi
}

update_git_work_commits() {
    local commit_msg="$1"
    commit_info=$(git log --author="lucas.reginatto@ifood.com.br" --pretty=format:"%h|%ae|%ad|$(git symbolic-ref --short HEAD)|%s|$(basename $(git rev-parse --show-toplevel))" --abbrev=8 --date=iso -n 1)
    echo $commit_info >> $HOME/git/git-work-commits/git-work-commits-data.txt

    # Get the infos
    IFS='|' read -r hascommit author date branch commitMsg repository <<< "$commit_info"

    # Generate a report easier to read
    echo "Commit: $hascommit" >> $HOME/git/git-work-commits/git-work-commits-report.txt
    echo "Author: $author" >> $HOME/git/git-work-commits/git-work-commits-report.txt
    echo "Date: $date" >> $HOME/git/git-work-commits/git-work-commits-report.txt
    echo "Branch: $branch" >> $HOME/git/git-work-commits/git-work-commits-report.txt
    echo "Commit Message: $commitMsg" >> $HOME/git/git-work-commits/git-work-commits-report.txt
    echo "Repository: $repository" >> $HOME/git/git-work-commits/git-work-commits-report.txt
    echo "-------------------" >> $HOME/git/git-work-commits/git-work-commits-report.txt

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
