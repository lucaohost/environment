xxs() {
    if grep -qE "(microsoft|WSL)" /proc/version &>/dev/null && [[ "$(uname -r)" != *Microsoft* ]]; then
        xxs_windows "$@"
    else
        xxs_ubuntu "$@"
    fi
}
xxs_windows() {
    if [[ -z "$1" ]]; then
        echo "Usage: xs_windows <minutes>"
        return 1
    fi
    minutes="$1"
    seconds=$((minutes * 60))
    wsl.exe -d ubuntu -- powershell.exe "Start-Sleep -Seconds $seconds; Stop-Computer"
}
xxs_ubuntu() {
    if [[ -z "$1" ]]; then
        echo "Usage: xs_ubuntu <minutes>"
        return 1
    fi
    minutes="$1"
    seconds=$((minutes * 60))
    sudo sleep "$seconds" && poweroff
}
