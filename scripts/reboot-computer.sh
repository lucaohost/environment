rbt() {
    echo "Reiniciando... Pressione Ctrl+C para cancelar."
    for i in {5..1}; do
        echo "$i..."
        sleep 1
    done

    if uname -a | grep -q "Microsoft\|WSL"; then
        wsl.exe -d ubuntu -- powershell.exe Restart-Computer
    elif uname -a | grep -q "Ubuntu"; then
        reboot
    fi
}
