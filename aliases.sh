# Paste the code below at the end of your ~/.bashrc
# My Aliases

# Go directory with all Github Projects.
alias codes='cd /mnt/c/git/'

# Remember my Bashes.
alias rmb='ll ~/bashes'

# Remeber my Aliases.
alias rma="grep -A 1000000 -E ' My\s+Aliases' ~/.bashrc | tail -n +2"

# Close Terminal
alias x="exit"

# Turn off computer
# On Ubuntu
# alias xx="poweroff"
# On WSL
alias xx="wsl.exe -d ubuntu -- powershell.exe Stop-Computer"

# Turn off computer after N minutes
xs() {
    if [[ -z "$1" ]]; then
        echo "Usage: xs <minutes>"
        return 1
    fi
    minutes="$1"
    seconds=$((minutes * 60))
    wsl.exe -d ubuntu -- powershell.exe "Start-Sleep -Seconds $seconds; Stop-Computer"
}

# Update Aliases
alias ua="/mnt/c/git/environment/update-aliases.sh"
