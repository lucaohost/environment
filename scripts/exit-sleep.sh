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
    sleep "$seconds"
    wsl.exe -d ubuntu -- powershell.exe "Add-Type -AssemblyName System.Windows.Forms;[System.Windows.Forms.Application]::SetSuspendState([System.Windows.Forms.PowerState]::Suspend, 'False', 'False')"
}

xs_ubuntu() {
    if [[ -z "$1" ]]; then
        echo "Usage: xs_ubuntu <minutes>"
        return 1
    fi
    minutes="$1"
    seconds=$((minutes * 60))
    sudo sleep "$seconds" && systemctl suspend
}
