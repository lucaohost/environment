#!/bin/bash
gu() {
    local commit_msg=""
    for param in "$@"; do
        # Adiciona o parâmetro à string
        commit_msg="$commit_msg$param "
    done
    commit_msg="${commit_msg%?}" #remove last white space
    git add -A
    git commit -m "$commit_msg"
    git push
}

