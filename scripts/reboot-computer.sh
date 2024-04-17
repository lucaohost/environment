if uname -a | grep -q "Microsoft\|WSL"; then
    alias rbt="wsl.exe -d ubuntu -- powershell.exe Restart-Computer"
elif uname -a | grep -q "Ubuntu"; then
    alias rbt="reboot"
fi
