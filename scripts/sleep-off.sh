xx() {
    if [[ -z "$1" ]]; then
        minutes=0
    else
        minutes=$1
    fi
    seconds=$((minutes * 60))
    if grep -qE "(microsoft|WSL)" /proc/version &>/dev/null && [[ "$(uname -r)" != *Microsoft* ]]; then
        xx_windows "$seconds"
    else
        xx_ubuntu "$seconds"
    fi
}

xx_windows() {
    wsl.exe -d ubuntu -- powershell.exe "Start-Sleep -Seconds $1; Stop-Computer"
}

xx_ubuntu() {
    sudo sleep "$1" && poweroff
}
