# c   = Codes (Go directory with all Codes of Github Projects)
alias c='cd $LUCAO_ENV && cd ..'

# rmb = Remember my Bashes
alias rmb="ls -1 $LUCAO_ENV/*.sh"

# rma = Remeber my Aliases
alias rma="grep -E '^#' $LUCAO_ENV/aliases.sh"

# x   = Exit (Close Terminal)
alias x="exit"

# xx  = Double Exit (Turn off the Computer)
if uname -a | grep -q "microsoft\|WSL"; then
    alias xx="wsl.exe -d ubuntu -- powershell.exe Stop-Computer"
elif uname -a | grep -q "Ubuntu"; then
    alias xx="poweroff"
fi

# xs  = Exit Sleep (Turn off the computer after N minutes) | Usage: xs 45
xs() {
    if grep -qE "(microsoft|WSL)" /proc/version &>/dev/null && [[ "$(uname -r)" != *Microsoft* ]]; then
        xs_windows "$@"
    else
        xs_ubuntu "$@"
    fi
}
xs_windows() {
    if [[ -z "$1" ]]; then
        echo "Usage: xs_windows <minutes>"
        return 1
    fi
    minutes="$1"
    seconds=$((minutes * 60))
    wsl.exe -d ubuntu -- powershell.exe "Start-Sleep -Seconds $seconds; Stop-Computer"
}
xs_ubuntu() {
    if [[ -z "$1" ]]; then
        echo "Usage: xs_ubuntu <minutes>"
        return 1
    fi
    minutes="$1"
    seconds=$((minutes * 60))
    su
    sleep "$seconds"
    systemctl suspend
}

# rb  = Reboot the computer
if uname -a | grep -q "Microsoft\|WSL"; then
    alias rb="wsl.exe -d ubuntu -- powershell.exe Restart-Computer"
elif uname -a | grep -q "Ubuntu"; then
    alias rb="reboot"
fi

# ea  = Edit Aliases
alias ea="nano $LUCAO_ENV/aliases.sh"

# ua  = Update Aliases
alias ua="$LUCAO_ENV/update-aliases.sh"

# eb  = Edit ~/.bashrc
alias eb="nano ~/.bashrc"

# gu  = Github Update (Commit All files and Push) | Usage: gu My commit message
gu() {
    local commit_msg=""
    for param in "$@"; do
        commit_msg="$commit_msg$param "
    done
    commit_msg="${commit_msg%?}" #remove last white space
    git add -A
    git commit -m "$commit_msg"
    git push
    echo "$commit_msg"
}

# cl  = Clear
alias cl=clear

# gcm = Goes to the default branch
gcm() {
    default_branch=$(git symbolic-ref refs/remotes/origin/HEAD | sed 's@^refs/remotes/origin/@@')
    git checkout "$default_branch"
}

# gcd = Goes to develop branch
alias gcd='git checkout $(git branch --list develop || echo dev)'

# gp  = Push commits 
alias gp='git push'

# gbd = Delete Branch
alias gbd='git branch -d'

# gbD = Delete Branch forcefully, even if it contains unmerged changes
alias gbD='git branch -D'

# gcb = Create a new branch
alias gcb='git checkout -b'

# gco = Checkout to another branch
alias gco='git checkout'

_git_checkout_complete() {
  # Get current word
  local current_word="${COMP_WORDS[COMP_CWORD]}"
  # Get list of branches
  local branches=$(git branch --list "${current_word}*" | sed 's/\*//g' | awk '{$1=$1};1')
  # Set completions to available branches
  COMPREPLY=($(compgen -W "$branches" -- "$current_word"))
}

complete -o default -F _git_checkout_complete gco
complete -o default -F _git_checkout_complete gbd
complete -o default -F _git_checkout_complete gbD


# gaa = Add all changes to commit
alias gaa='git add --all'

# gl  = Git Pull
alias gl='git pull'

# gst = Git Status
alias gst='git status'

# gpu = Git Push -u origin
alias gpu='git push -u origin $(git rev-parse --abbrev-ref HEAD)'

# ~   = cd ~
alias ~="cd ~"

# ..  = cd ..
alias ".."="cd .."

# bkl = Backup Locally of Changed Files
alias bkl="$LUCAO_ENV/backup-changed-files.sh"

# bkg = Backup in Github of Changed Files
bkg() {
    current_branch=$(git rev-parse --abbrev-ref HEAD)
    git stash
    git stash apply
    datetime=$(date +"%Y-%m-%d_%H-%M-%S")
    bkp_branch="backup/${datetime}"
    git checkout -b $bkp_branch
    git add -A
    git commit -m "backup"
    git push -u origin $bkp_branch
    git checkout $current_branch
    git stash apply
    echo "Github Backup Completed in branch: ${bkp_branch}"
}

# gss = git stash
alias gss="git stash"

# gsa = git stash apply
alias gsa="git stash apply"

# gsl = git stash list
alias gsl="git stash list"

# gb  = git branch
alias gb="git branch"
