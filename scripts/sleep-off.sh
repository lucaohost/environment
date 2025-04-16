off() {
    if [[ -z "$1" ]]; then
        minutes=0
    else
        minutes=$1
    fi
    seconds=$((minutes * 60))
    if [[ "$OPERATIONAL_SYSTEM" == "WSL" ]]; then
        off_windows "$seconds"
    else
        off_ubuntu "$seconds"
    fi
}

off_windows() {
    wsl.exe -d ubuntu -- powershell.exe "Start-Sleep -Seconds $1; Stop-Computer"
}

off_ubuntu() {
    sleep "$1" && poweroff
}
