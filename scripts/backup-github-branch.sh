bkb() {
    current_branch=$(git rev-parse --abbrev-ref HEAD)
    git add -A
    git stash
    git stash apply
    datetime=$(date +"%Y-%m-%d_%H-%M-%S")
    bkp_branch="backup/${datetime}"
    git checkout -b $bkp_branch
    git add -A
    git commit -m "backup: Add automatic backup"
    git push -u origin $bkp_branch
    git checkout $current_branch
    git stash apply
    echo "Github Backup Completed in branch: ${bkp_branch}"
}