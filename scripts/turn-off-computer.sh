if uname -a | grep -q "microsoft\|WSL"; then
    alias xx="wsl.exe -d ubuntu -- powershell.exe Stop-Computer"
elif uname -a | grep -q "Ubuntu"; then
    alias xx="poweroff"
fi