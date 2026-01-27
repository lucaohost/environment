off() {
    if [[ "$1" == *":"* ]]; then
        target_time="$1"
        target_timestamp=$(date -d "$target_time" +%s)
        current_timestamp=$(date +%s)
        seconds=$((target_timestamp - current_timestamp))
        if [ $seconds -lt 0 ]; then
            # If the time is in the past, assume it's for tomorrow
            target_timestamp=$(date -d "tomorrow $target_time" +%s)
            seconds=$((target_timestamp - current_timestamp))
        fi
    else
        if [[ -z "$1" ]]; then
            minutes=0
        else
            minutes=$1
        fi
        seconds=$((minutes * 60))
    fi

    if [[ "$OPERATIONAL_SYSTEM" == "WSL" ]]; then
        off_windows "$seconds"
    else
        off_ubuntu "$seconds"
    fi
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
    off
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
