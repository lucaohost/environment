bkb() {
    current_branch=$(command git rev-parse --abbrev-ref HEAD)
    command git add -A
    command git stash
    command git stash apply
    datetime=$(date +"%Y-%m-%d_%H-%M-%S")
    bkp_branch="backup/${datetime}"
    command git checkout -b $bkp_branch
    command git add -A
    command git commit -m "backup: Add automatic backup"
    command git push -u origin $bkp_branch
    command git checkout $current_branch
    command git stash apply
    echo "Github Backup Completed in branch: ${bkp_branch}"
}