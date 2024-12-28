vid() {
    if grep -qEi "(Microsoft|WSL)" /proc/version &> /dev/null; then
        cd "/mnt/c/Users/$(whoami)/Videos"
    else
        cd "$(xdg-user-dir VIDEOS)"
    fi
}