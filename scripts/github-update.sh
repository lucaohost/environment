gu() {
    commit_and_reflect "$*" "$*"
}

guc() {
    commit_and_reflect "$*" "feat: CENSORED_COMMIT_MESSAGE"
}

commit_and_reflect() {
    local commit_msg="$1"
    local reflect_msg="$2"

    git_commit_and_push "$commit_msg"

    reflect_last_commit_on_personal_github "$reflect_msg"

}

git_commit_and_push() {
    local commit_msg="$1"
    local repo_name=$(basename "$(git rev-parse --show-toplevel)")
    if [[ "$(hostname)" == "18049-nb" ]]; then
        git config --global user.email "$PROFESSIONAL_EMAIL"
        git config --local user.email "$PROFESSIONAL_EMAIL"
    else
        git config --global user.email "$PERSONAL_EMAIL"
        git config --local user.email "$PERSONAL_EMAIL"
    fi
    if [[ "$repo_name" == "environment" || "$repo_name" == "my-notes" || "$repo_name" == "private-notes" || "$repo_name" == "git-work-commits" ]]; then
        git config --global user.email "$PERSONAL_EMAIL"
        git config --local user.email "$PERSONAL_EMAIL"
    fi
    git add -A
    git commit -m "$(printf "%b" "$commit_msg")"
    git push --set-upstream origin $(git rev-parse --abbrev-ref HEAD)
    if [[ "$(hostname)" == "18049-nb" ]]; then
        git config --global user.email "$PROFESSIONAL_EMAIL"
        git config --local user.email "$PROFESSIONAL_EMAIL"
    fi
}

reflect_last_commit_on_personal_github() {
    local commit_msg="$*"

    # It doesn't reflect commits on personal computer
    if [ $(hostname) == "LucaS" ]; then 
        return 1
    fi

    if [ -z "$PERSONAL_EMAIL" ] || [ -z "$PROFESSIONAL_EMAIL" ]; then
        echo "Error: PERSONAL_EMAIL or PROFESSIONAL_EMAIL is not set."
        return 1
    fi

    commit_info=$(git log --author="$PROFESSIONAL_EMAIL" --pretty=format:"%h|%ae|%ad|$(git symbolic-ref --short HEAD)|%s|$(basename $(git rev-parse --show-toplevel))" --abbrev=8 --date=format:'%Y-%m-%dT%H:%M:%S-03:00' -n 1 | awk -F'|' 'BEGIN {OFS="|"} { if (index($5, " -")) $5 = substr($5, 1, index($5, " -") - 1); print $0 }')
    if [ -z "$commit_info" ]; then
        echo "Error: Commit info is empty. Stopping script."
        return 1
    fi
    # Extract commit info
    IFS='|' read -r hashCommit author date branch commitMsg repo_name <<< "$commit_info"

    # It doesn't reflect commits on personal repositories
    if [[ "$repo_name" == "environment" || "$repo_name" == "my-notes" || "$repo_name" == "private-notes" ]]; then
        return 1
    fi
    
    echo $commit_info >> $HOME/git/git-work-commits/git-work-commits-data.txt

    # Generate a report easier to read
    {
        echo "Commit: $hashCommit"
        echo "Author: $author"
        echo "Date: $date"
        echo "Branch: $branch"
        echo "Commit Message: $commit_msg"
        echo "Repository: $repo_name"
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

gp () {
    commit_info=$(git log --author="$PROFESSIONAL_EMAIL" --pretty=format:"%h|%ae|%ad|$(git symbolic-ref --short HEAD)|%s|$(basename $(git rev-parse --show-toplevel))" --abbrev=8 --date=format:'%Y-%m-%dT%H:%M:%S-03:00' -n 1 | awk -F'|' 'BEGIN {OFS="|"} { if (index($5, " -")) $5 = substr($5, 1, index($5, " -") - 1); print $0 }')
    IFS='|' read -r hashCommit author date branch commitMsg repo_name <<< "$commit_info"
    git push
    reflect_last_commit_on_personal_github "$commitMsg"
}

gpp () {
    commit_info=$(git log --author="$PROFESSIONAL_EMAIL" --pretty=format:"%h|%ae|%ad|$(git symbolic-ref --short HEAD)|%s|$(basename $(git rev-parse --show-toplevel))" --abbrev=8 --date=format:'%Y-%m-%dT%H:%M:%S-03:00' -n 1 | awk -F'|' 'BEGIN {OFS="|"} { if (index($5, " -")) $5 = substr($5, 1, index($5, " -") - 1); print $0 }')
    IFS='|' read -r hashCommit author date branch commitMsg repo_name <<< "$commit_info"
    git push --force
    reflect_last_commit_on_personal_github "$commitMsg"
}

gpu () {
    commit_info=$(git log --author="$PROFESSIONAL_EMAIL" --pretty=format:"%h|%ae|%ad|$(git symbolic-ref --short HEAD)|%s|$(basename $(git rev-parse --show-toplevel))" --abbrev=8 --date=format:'%Y-%m-%dT%H:%M:%S-03:00' -n 1 | awk -F'|' 'BEGIN {OFS="|"} { if (index($5, " -")) $5 = substr($5, 1, index($5, " -") - 1); print $0 }')
    IFS='|' read -r hashCommit author date branch commitMsg repo_name <<< "$commit_info"
    git push --set-upstream origin $(git rev-parse --abbrev-ref HEAD)
    reflect_last_commit_on_personal_github "$commitMsg"
}