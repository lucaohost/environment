open() {
    if grep -qE "(microsoft|WSL)" /proc/version &>/dev/null && [[ "$(uname -r)" != *Microsoft* ]]; then
        explorer.exe .
    else
        xdg-open .
    fi
}
