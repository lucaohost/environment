gcm() {
    default_branch=$(command git symbolic-ref refs/remotes/origin/HEAD | sed 's@^refs/remotes/origin/@@')
    command git checkout "$default_branch"
}