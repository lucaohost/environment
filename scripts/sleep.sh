slp() {
    if [[ -z "$1" ]]; then
        minutes=0
    else
        minutes=$1
    fi
    seconds=$((minutes * 60))
    if grep -qE "(microsoft|WSL)" /proc/version &>/dev/null && [[ "$(uname -r)" != *Microsoft* ]]; then
        slp_windows "$seconds"
    else
        slp_ubuntu "$seconds"
    fi
}

slp_windows() {
    sleep "$1"
    wsl.exe -d ubuntu -- powershell.exe "Add-Type -AssemblyName System.Windows.Forms;[System.Windows.Forms.Application]::SetSuspendState([System.Windows.Forms.PowerState]::Suspend, 'False', 'False')"
}

slp_ubuntu() {
    sudo sleep "$1" && systemctl suspend
}
