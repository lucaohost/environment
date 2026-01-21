source $HOME/git/environment/scripts/variables.sh

# c     = Codes (Directory with all Projects | Tab to autocomplete)
# vs    = Open project in VSCode (Tab to autocomplete)
source $HOME/git/environment/scripts/code-dir.sh

# rmb   = Remember my Bashes
alias rmb="ls -1 $HOME/git/environment/scripts/*.sh"

# rma   = Remeber my Aliases
alias rma="grep -E '^#' $HOME/git/environment/aliases.sh"

# x     = Exit (Close Terminal)
alias x="exit"

# off   = Turn off immediatly or after N minutes| Usage: off or off 45
source $HOME/git/environment/scripts/sleep-off.sh

# slp   = Sleep (Sleep immediatly or after N minutes) | Usage: slp or slp 45
source $HOME/git/environment/scripts/sleep.sh

# rbt   = Reboot the computer
source $HOME/git/environment/scripts/reboot-computer.sh

# eal   = Edit Aliases
alias eal="nano $HOME/git/environment/aliases.sh"

# eba   = Edit ~/.bashrc
alias eba="nano ~/.bashrc"

# gu    = Github Update (Commit All files and Push) | Usage: gu My commit message\n-My commit description
# guc   = Github Update Censored (Commit All files and Push, but censor message reflecting commit)
# rlc   = Reflect Last Commit on Personal Github | Usage: rlc My commit message
# gp    = Push commits 
# gpp   = Push commits forcefully
# gpu   = git push --set-upstream origin $current_branch
# gln   = git pull Notes (folders my-notes and private-code-notes)
# gpn   = git push Notes (folders my-notes and private-code-notes)
# gsn   = git status Notes (folders my-notes and private-code-notes)
# notes = Open Notes Project on VSCode
source $HOME/git/environment/scripts/github-update.sh

# cl    = Clear
alias cl=clear

# gcm   = Goes to the main/master (default branch)
source $HOME/git/environment/scripts/git-checkout-main.sh

# gcd   = Goes to develop branch
alias gcd='git checkout $(git branch --list develop || echo dev)'

# gbd   = Delete Branch
alias gbd='git branch -d'

# gbD   = Delete Branch forcefully, even if it contains unmerged changes
alias gbD='git branch -D'

# gcb   = Create a new branch
alias gcb='git checkout -b'

# gco   = Checkout to another branch
alias gco='git checkout'

source $HOME/git/environment/scripts/git-branch-complete.sh

# gaa   = Add all changes to commit
alias gaa='git add --all'

# gl    = Git Pull
alias gl='git pull'

# gst   = Git Status
alias gst='git status'

# ~     = cd ~
alias ~="cd ~"

# ..    = cd ..
alias ".."="cd .."

# bkb   = Backup. Push changed files in a backup branch.
source $HOME/git/environment/scripts/backup-github-branch.sh

# gss   = git stash
alias gss="git stash"

# gsa   = git stash apply
alias gsa="git stash apply"

# gsl   = git stash list
alias gsl="git stash list"

# gb    = git branch
alias gb="git branch"

# gpv   = Git Push Version (Add all changes and commit with incremented version)
source $HOME/git/environment/scripts/git-push-version.sh

# uar   = Update All Repositories
source $HOME/git/environment/scripts/update-all-repos.sh

# vcc   = Verify Changes to Commit in All Repositories
source $HOME/git/environment/scripts/verify-changes-to-commit.sh

# open  = Open current directory in explorer
source $HOME/git/environment/scripts/open-dir.sh

# hist  = Print the terminal's history
alias hist="history"

# dhist = Dump terminal's history in ~/git/notes/private-code-notes/terminal-history.txt
alias dhist="history > ~/git/notes/private-code-notes/terminal-history.txt"

# jver  = Change the Java Version
alias jver="sudo update-alternatives --config java"

# gcam  = git commit -m | Usage: gcam My commit message\n-My commit description
source $HOME/git/environment/scripts/git-commit-m.sh

# code  = Open VS Code | Usage: code .
export DONT_PROMPT_WSL_INSTALL=true

# intj  = Open InteliJ
alias intj='(intellij-idea-community > /dev/null 2>&1 &)'

# downl = Open Downloads folder
source $HOME/git/environment/scripts/open-downloads.sh

# vid   = Open Videos folder
source $HOME/git/environment/scripts/open-videos.sh

# editv = Make my basic edit video | Usage: editv video.mp4
source $HOME/git/environment/scripts/edit-video.sh

# prof  = Set Professional Email
alias prof='git config --global user.email $PROFESSIONAL_EMAIL && git config user.email $PROFESSIONAL_EMAIL'

# pers  = Set Personal Email
alias pers='git config --global user.email $PERSONAL_EMAIL && git config user.email $PERSONAL_EMAIL'

# email = Show current email
alias email='echo "Global email: $(git config --global user.email)"; echo "Local email: $(git config user.email)"'

# glog  = git log
alias glog='git log'

# tab   = Open new Terminal Tab
# tabx  = Open new Terminal Tab and Close the current one
source $HOME/git/environment/scripts/tab.sh

# leet = Create folder/file to store a LeetCode problem | Usage: leet my-example
source $HOME/git/environment/scripts/leet.sh

source ~/git/notes/private-code-notes/private-aliases.sh