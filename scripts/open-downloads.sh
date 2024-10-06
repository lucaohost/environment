downl() {
    if grep -qEi "(Microsoft|WSL)" /proc/version &> /dev/null; then
        cd "/mnt/c/Users/$(whoami)/Downloads"
    else
        cd "$(xdg-user-dir DOWNLOAD)"
    fi
}