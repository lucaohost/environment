
if [[ "$OPERATIONAL_SYSTEM" == "WSL" ]]; then
    alias tab='cmd.exe /c "wt -w 0 new-tab wsl -d Ubuntu"'
    alias tabx='cmd.exe /c "wt -w 0 new-tab wsl -d Ubuntu"; exit'
else
    alias tab='gnome-terminal --tab'
    alias tabx='gnome-terminal --tab; exit'
fi
