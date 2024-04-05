# Paste the code below at the end of your ~/.bashrc
# My Aliases

# Go directory with all Codes of Github Projects.
# c = codes
alias c='cd /mnt/c/git/'

# Remember my Bashes.
alias rmb='ll ~/bashes'

# Remeber my Aliases.
alias rma="grep -A 1000000 -E ' My\s+Aliases' ~/.bashrc | tail -n +2"

# Close Terminal
# x = Exit
alias x="exit"

# Turn off the Computer
# xx = Double Exit
set_xx_alias() {
    if uname -a | grep -q "Microsoft\|WSL"; then
        alias xx="wsl.exe -d ubuntu -- powershell.exe Stop-Computer"
    elif uname -a | grep -q "Ubuntu"; then
        alias xx="poweroff"
    fi
}

# Turn off the computer after N minutes
# xs = Exit Sleep
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

# Reboot the Computer
if uname -a | grep -q "Microsoft\|WSL"; then
    alias r="wsl.exe -d ubuntu -- powershell.exe Restart-Computer"
elif uname -a | grep -q "Ubuntu"; then
    alias r="reboot"
fi

# Update Aliases
alias ua="/mnt/c/git/environment/update-aliases.sh"
