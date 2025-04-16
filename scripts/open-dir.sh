open() {
    if [[ "$OPERATIONAL_SYSTEM" == "WSL" ]]; then
        explorer.exe .
    else
        xdg-open .
    fi
}
