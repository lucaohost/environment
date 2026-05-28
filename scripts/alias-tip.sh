#!/bin/bash

# Extract alias descriptions (lines starting with #) and show a random tip
ALIASES_FILE="$HOME/git/environment/aliases.sh"

if [[ ! -f "$ALIASES_FILE" ]]; then
    return
fi

# Extract all comment lines that describe aliases (format: # command = description)
ALIAS_TIPS=$(grep -E '^\s*#\s+[a-zA-Z~\.]' "$ALIASES_FILE" | grep '=' | sed 's/^[[:space:]]*//')

# Count how many tips we have
TIP_COUNT=$(echo "$ALIAS_TIPS" | wc -l)

if [[ $TIP_COUNT -gt 0 ]]; then
    # Select a random line (1 to TIP_COUNT)
    RANDOM_LINE=$((RANDOM % TIP_COUNT + 1))

    # Get the random tip
    TIP=$(echo "$ALIAS_TIPS" | sed -n "${RANDOM_LINE}p")

    # Display with styling
    echo -e "\033[1;36m💡 Alias Tip:\033[0m $TIP"
fi
