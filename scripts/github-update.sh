commit_and_reflect() {
    local commit_msg="$1"
    local reflect_msg="$2"

    git_commit_and_push "$commit_msg"

    if [ $(hostname) != "LucaS" ]; then
        reflect_last_commit_on_personal_github "$reflect_msg"
    fi
}

git_commit_and_push() {
    local commit_msg="$1"
    git add -A
    git commit -m "$(printf "%b" "$commit_msg")"
    git push --set-upstream origin $(git rev-parse --abbrev-ref HEAD)
}

gu() {
    commit_and_reflect "$*" "$*"
}

guc() {
    commit_and_reflect "$*" "feat: CENSORED_COMMIT_MESSAGE"
}

reflect_last_commit_on_personal_github() {
    local commit_msg="$1"

    if [ -z "$PERSONAL_EMAIL" ] || [ -z "$PROFESSIONAL_EMAIL" ]; then
        echo "Error: PERSONAL_EMAIL or PROFESSIONAL_EMAIL is not set."
        return 1
    fi

    commit_info=$(git log --author="$PROFESSIONAL_EMAIL" --pretty=format:"%h|%ae|%ad|$(git symbolic-ref --short HEAD)|$commit_msg|$(basename $(git rev-parse --show-toplevel))" --abbrev=8 --date=format:'%Y-%m-%dT%H:%M:%S-03:00' -n 1)
    echo $commit_info >> $HOME/git/git-work-commits/git-work-commits-data.txt

    # Extract commit info
    IFS='|' read -r hascommit author date branch commitMsg repository <<< "$commit_info"

    # Generate a report easier to read
    {
        echo "Commit: $hascommit"
        echo "Author: $author"
        echo "Date: $date"
        echo "Branch: $branch"
        echo "Commit Message: $commitMsg"
        echo "Repository: $repository"
        echo "-------------------"
    } >> $HOME/git/git-work-commits/git-work-commits-report.txt

    current_dir=$(pwd)
    cd $HOME/git/git-work-commits/
    git config --global user.email $PERSONAL_EMAIL
    git add -A
    git commit -m "$(printf "%b" "$commit_msg")"
    git push
    cd $current_dir
    git config --global user.email $PROFESSIONAL_EMAIL
}