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