gcam() {
    local commit_msg=""
    for param in "$@"; do
        commit_msg="$commit_msg$param "
    done
    commit_msg="${commit_msg%?}" #remove last white space
    local repo_name=$(basename "$(git rev-parse --show-toplevel)")

    if [[ -z "$PERSONAL_EMAIL" || -z "$PROFESSIONAL_EMAIL" ]]; then
        echo "Warning: PERSONAL_EMAIL and/or PROFESSIONAL_EMAIL environment variables are not set."
        return 1
    fi
    local repo_owner=$(git remote get-url origin | sed -E 's#.*/([^/]+)/[^/]+(\.git)?#\1#')
    if [ "$repo_owner" == "lucaohost" ]; then
        git config --global user.email "$PERSONAL_EMAIL"
        git config --local user.email "$PERSONAL_EMAIL"
    fi

    git commit -m "$(printf "%b" "$commit_msg")"  # Interpreta o \n como nova linha

    # By default, when I'm in my professional computer, I'll set my professional email after commiting
    if [[ "$(hostname)" == "18049-nb" ]]; then
        git config --global user.email "$PROFESSIONAL_EMAIL"
        git config --local user.email "$PROFESSIONAL_EMAIL"
    else 
        git config --global user.email "$PERSONAL_EMAIL"
        git config --local user.email "$PERSONAL_EMAIL"
    fi
}