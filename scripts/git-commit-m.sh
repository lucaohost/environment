gcam() {
    local commit_msg=""
    for param in "$@"; do
        commit_msg="$commit_msg$param "
    done
    commit_msg="${commit_msg%?}" #remove last white space
    git commit -m "$(printf "%b" "$commit_msg")"  # Interpreta o \n como nova linha
}