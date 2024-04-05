# Paste the line below without # in your ~/.bashrc
# source /mnt/c/git/environment/aliases.sh

# My Aliases

# c = Codes (Go directory with all Codes of Github Projects)
alias c='cd /mnt/c/git/'

# rmb = Remember my Bashes
alias rmb='ls -1 /mnt/c/git/environment/*.sh'

# rma = Remeber my Aliases
alias rma="grep -A 1000000 -E ' My\s+Aliases' ~/.bashrc | tail -n +2"

# x = Exit (Close Terminal)
alias x="exit"

# xx = Double Exit (Turn off the Computer)
if uname -a | grep -q "microsoft\|WSL"; then
    alias xx="wsl.exe -d ubuntu -- powershell.exe Stop-Computer"
elif uname -a | grep -q "Ubuntu"; then
    alias xx="poweroff"
fi

# xs = Exit Sleep (Turn off the computer after N minutes)
# Usage: xs 45
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
    sudo systemctl suspend
}

# r = Reboot the computer
if uname -a | grep -q "Microsoft\|WSL"; then
    alias r="wsl.exe -d ubuntu -- powershell.exe Restart-Computer"
elif uname -a | grep -q "Ubuntu"; then
    alias r="reboot"
fi

# ua = Update Aliases
alias ua="/mnt/c/git/environment/update-aliases.sh"
