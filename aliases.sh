# c   = Codes (Go directory with all Codes of Github Projects)
alias c='cd $LUCAO_ENV && cd ..'

# rmb = Remember my Bashes
alias rmb="ls -1 $LUCAO_ENV/*.sh"

# rma = Remeber my Aliases
alias rma="grep -E '^#' $LUCAO_ENV/aliases.sh"

# x   = Exit (Close Terminal)
alias x="exit"

# xx  = Double Exit (Turn off the Computer)
source $LUCAO_ENV/scripts/turn-off-computer.sh

# xs  = Exit Sleep (Turn off the computer after N minutes) | Usage: xs 45
source $LUCAO_ENV/scripts/exit-sleep.sh

# rb  = Reboot the computer
source $LUCAO_ENV/scripts/reboot-computer.sh

# ea  = Edit Aliases
alias ea="nano $LUCAO_ENV/aliases.sh"

# ua  = Update Aliases
alias ua="$LUCAO_ENV/scripts/update-aliases.sh"

# eb  = Edit ~/.bashrc
alias eb="nano ~/.bashrc"

# gu  = Github Update (Commit All files and Push) | Usage: gu My commit message
source $LUCAO_ENV/scripts/github-update.sh

# cl  = Clear
alias cl=clear

# gcm = Goes to the main/master (default branch)
source $LUCAO_ENV/scripts/git-checkout-main.sh

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

source $LUCAO_ENV/scripts/git-auto-complete.sh

# gaa = Add all changes to commit
alias gaa='git add --all'

# gl  = Git Pull
alias gl='git pull'

# gst = Git Status
alias gst='git status'

# gpu = Git Push -u origin
alias gpu='git push --set-upstream origin $(git rev-parse --abbrev-ref HEAD)'

# ~   = cd ~
alias ~="cd ~"

# ..  = cd ..
alias ".."="cd .."

# bcf = Backup Locally of Changed Files
alias bcf="$LUCAO_ENV/scripts/backup-changed-files.sh"

# bkg = Backup in Github of Changed Files
source $LUCAO_ENV/scripts/backup-github.sh

# gss = git stash
alias gss="git stash"

# gsa = git stash apply
alias gsa="git stash apply"

# gsl = git stash list
alias gsl="git stash list"

# gb  = git branch
alias gb="git branch"

# uar = Update All Repositories
alias uar="$LUCAO_ENV/scripts/update-all-repos.sh"

# vcc = Verify Changes to Commit in All Repositories
alias vcc="$LUCAO_ENV/scripts/verify-changes-to-commit.sh"
