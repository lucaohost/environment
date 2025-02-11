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
    set_git_email_based_on_hostname
    local repo_owner=$(git remote get-url origin | sed -E 's#.*/([^/]+)/[^/]+(\.git)?#\1#')
    if [ "$repo_owner" == "lucaohost" ]; then
        git config --global user.email "$PERSONAL_EMAIL"
        git config --local user.email "$PERSONAL_EMAIL"
    fi
    git add -A
    git commit -m "$(printf "%b" "$commit_msg")"
    git push --set-upstream origin $(git rev-parse --abbrev-ref HEAD)
    set_git_email_based_on_hostname
}

reflect_last_commit_on_personal_github() {
    local commit_msg="$*"
    set_git_email_based_on_hostname

    if [ -z "$PERSONAL_EMAIL" ] || [ -z "$PROFESSIONAL_EMAIL" ]; then
        echo "Error: PERSONAL_EMAIL or PROFESSIONAL_EMAIL is not set."
        return 1
    fi
    
    local github_username=$(git remote get-url origin | sed -E 's#.*github.com[:/](.*)/.*#\1#')
    if [ "$github_username" == "lucaohost" ]; then
        echo "Warning: Stopping script, it doesn't reflect on personal repositories."
        return 1
    fi

    commit_info=$(git log --author="$PROFESSIONAL_EMAIL" --pretty=format:"%h|%ae|%ad|$(git symbolic-ref --short HEAD)|%s|$(basename $(git rev-parse --show-toplevel))" --abbrev=8 --date=format:'%Y-%m-%dT%H:%M:%S-03:00' -n 1 | awk -F'|' 'BEGIN {OFS="|"} { if (index($5, " -")) $5 = substr($5, 1, index($5, " -") - 1); print $0 }')
    if [ -z "$commit_info" ]; then
        echo "Error: Commit info is empty. Stopping script."
        return 1
    fi
    # Extract commit info
    IFS='|' read -r hashCommit author date branch commitMsg repo_name <<< "$commit_info"

    local college_repo="PCVS"
    if [ "$repo_name" == "$college_repo" ]; then
        if [ -z "$COLLEGE_EMAIL" ]; then
            echo "Warning: COLLEGE_EMAIL is not set. Stopping script."
            return 1
        fi
        commit_info="$hashCommit|$COLLEGE_EMAIL|$date|$branch|$commit_msg|$repo_name"
        author=$COLLEGE_EMAIL
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
    git config --local user.email $PERSONAL_EMAIL
    git add -A
    git commit -m "$(printf "%b" "$commit_msg")"
    git push
    cd $current_dir
    set_git_email_based_on_hostname
}

gp () {
    commit_info=$(git log --author="$PROFESSIONAL_EMAIL" --pretty=format:"%h|%ae|%ad|$(git symbolic-ref --short HEAD)|%s|$(basename $(git rev-parse --show-toplevel))" --abbrev=8 --date=format:'%Y-%m-%dT%H:%M:%S-03:00' -n 1 | awk -F'|' 'BEGIN {OFS="|"} { if (index($5, " -")) $5 = substr($5, 1, index($5, " -") - 1); print $0 }')
    IFS='|' read -r hashCommit author date branch commitMsg repo_name <<< "$commit_info"
    local repo_owner=$(git remote get-url origin | sed -E 's#.*/([^/]+)/[^/]+(\.git)?#\1#')
    if [ "$repo_owner" == "lucaohost" ]; then
        git config --global user.email "$PERSONAL_EMAIL"
        git config --local user.email "$PERSONAL_EMAIL"
    fi
    git push
    reflect_last_commit_on_personal_github "$commitMsg"
}

gpp () {
    commit_info=$(git log --author="$PROFESSIONAL_EMAIL" --pretty=format:"%h|%ae|%ad|$(git symbolic-ref --short HEAD)|%s|$(basename $(git rev-parse --show-toplevel))" --abbrev=8 --date=format:'%Y-%m-%dT%H:%M:%S-03:00' -n 1 | awk -F'|' 'BEGIN {OFS="|"} { if (index($5, " -")) $5 = substr($5, 1, index($5, " -") - 1); print $0 }')
    IFS='|' read -r hashCommit author date branch commitMsg repo_name <<< "$commit_info"
    local repo_owner=$(git remote get-url origin | sed -E 's#.*/([^/]+)/[^/]+(\.git)?#\1#')
    if [ "$repo_owner" == "lucaohost" ]; then
        git config --global user.email "$PERSONAL_EMAIL"
        git config --local user.email "$PERSONAL_EMAIL"
    fi
    git push --force
    reflect_last_commit_on_personal_github "$commitMsg"
}

gpu () {
    commit_info=$(git log --author="$PROFESSIONAL_EMAIL" --pretty=format:"%h|%ae|%ad|$(git symbolic-ref --short HEAD)|%s|$(basename $(git rev-parse --show-toplevel))" --abbrev=8 --date=format:'%Y-%m-%dT%H:%M:%S-03:00' -n 1 | awk -F'|' 'BEGIN {OFS="|"} { if (index($5, " -")) $5 = substr($5, 1, index($5, " -") - 1); print $0 }')
    IFS='|' read -r hashCommit author date branch commitMsg repo_name <<< "$commit_info"
    local repo_owner=$(git remote get-url origin | sed -E 's#.*/([^/]+)/[^/]+(\.git)?#\1#')
    if [ "$repo_owner" == "lucaohost" ]; then
        git config --global user.email "$PERSONAL_EMAIL"
        git config --local user.email "$PERSONAL_EMAIL"
    fi
    git push --set-upstream origin $(git rev-parse --abbrev-ref HEAD)
    reflect_last_commit_on_personal_github "$commitMsg"
}

gln() {
    local before_script_directory=$(pwd)
    cd $HOME/git/notes/private-code-notes
    git pull
    cd $HOME/git/notes/my-notes
    git pull
    cd $before_script_directory
}

gsn() {
    local before_script_directory=$(pwd)
    cd $HOME/git/notes/my-notes
    git status
    cd $HOME/git/notes/private-code-notes
    git status
    cd $before_script_directory
}

notes() {
    local before_script_directory=$(pwd)
    c notes
    code .
    cd $before_script_directory
}

set_git_email_based_on_hostname() {
    if [[ "$(hostname)" == "18049-nb" ]]; then
        git config --global user.email "$PROFESSIONAL_EMAIL"
        git config --local user.email "$PROFESSIONAL_EMAIL"
    else 
        git config --global user.email "$PERSONAL_EMAIL"
        git config --local user.email "$PERSONAL_EMAIL"
    fi
}
