_off_resolve_seconds() {
    if [[ "$1" == *":"* ]]; then
        local target_time="$1"
        local target_timestamp=$(date -d "$target_time" +%s)
        local current_timestamp=$(date +%s)
        local seconds=$((target_timestamp - current_timestamp))
        if [ $seconds -lt 0 ]; then
            target_timestamp=$(date -d "tomorrow $target_time" +%s)
            seconds=$((target_timestamp - current_timestamp))
        fi
    else
        local minutes=${1:-0}
        local seconds=$((minutes * 60))
    fi
    echo "$seconds"
}

_off_execute() {
    if [[ "$OPERATIONAL_SYSTEM" == "WSL" ]]; then
        off_windows "$1"
    else
        off_ubuntu "$1"
    fi
}

off() {
    local seconds
    seconds=$(_off_resolve_seconds "$1")

    echo "Desligando... Pressione Ctrl+C para cancelar."
    for i in {5..1}; do
        echo "$i..."
        sleep 1
    done

    _off_execute "$seconds"
}

sextou() {
    clear
    # Frame 1 - canecas afastadas
    echo ""
    echo "    🍺                        🍺"
    echo ""
    echo "         S E X T O U !"
    sleep 0.4

    clear
    # Frame 2 - canecas se aproximando
    echo ""
    echo "        🍺                🍺"
    echo ""
    echo "         S E X T O U !"
    sleep 0.4

    clear
    # Frame 3 - canecas mais próximas
    echo ""
    echo "            🍺        🍺"
    echo ""
    echo "         S E X T O U !"
    sleep 0.4

    clear
    # Frame 4 - canecas brindando
    echo ""
    echo "               🍺🍺"
    echo "             * CLINK *"
    echo "         S E X T O U !"
    sleep 0.5

    clear
    # Frame 5 - celebração
    echo ""
    echo "            🍺✨✨🍺"
    echo "             CHEERS!"
    echo "         S E X T O U !"
    sleep 0.5

    clear
    # Frame 6 - final
    echo ""
    echo "               🍻"
    echo "         S E X T O U !"
    echo ""
    sleep 1

    echo "Desligando em:"
    for i in {5..0}; do
        echo "$i"
        sleep 1
    done
    _off_execute 0
}

pai_ta_off() {
    off
}

out() {
    off
}

afk() {
    off
}

off_windows() {
    wsl.exe -d ubuntu -- powershell.exe "Start-Sleep -Seconds $1; Stop-Computer"
}

off_ubuntu() {
    sleep "$1" && poweroff
}
