#!/bin/bash
# alias-help.sh
# Adds --help support to all aliases/functions in aliases.sh and private-aliases.sh.
# Running `name --help` shows its description and full code.

declare -A __ALIAS_HELP_DESC
declare -A __ALIAS_HELP_CODE
declare -a __ALIAS_HELP_NAMES  # all names found in files (documented or not)

__alias_help_parse() {
    local file="$1"
    [ -f "$file" ] || return
    while IFS= read -r line; do
        # Description comments: # name   = description
        if [[ "$line" =~ ^#[[:space:]]+([a-zA-Z_][a-zA-Z0-9_-]*)[[:space:]]+=([^=].*)$ ]]; then
            __ALIAS_HELP_DESC["${BASH_REMATCH[1]}"]="${BASH_REMATCH[2]# }"
        fi
        # alias name='cmd' or alias name="cmd"
        if [[ "$line" =~ ^alias[[:space:]]+([a-zA-Z_][a-zA-Z0-9_-]*)=(.+)$ ]]; then
            local _n="${BASH_REMATCH[1]}" _c="${BASH_REMATCH[2]}"
            [[ "$_c" =~ ^\'(.*)\'$ ]] && _c="${BASH_REMATCH[1]}"
            [[ "$_c" =~ ^\"(.*)\"$ ]] && _c="${BASH_REMATCH[1]}"
            __ALIAS_HELP_CODE["$_n"]="$_c"
            __ALIAS_HELP_NAMES+=("$_n")
        fi
        # function definitions: name() { or function name {
        if [[ "$line" =~ ^([a-zA-Z_][a-zA-Z0-9_-]*)[[:space:]]*\(\) ]] || \
           [[ "$line" =~ ^function[[:space:]]+([a-zA-Z_][a-zA-Z0-9_-]*) ]]; then
            __ALIAS_HELP_NAMES+=("${BASH_REMATCH[1]}")
        fi
    done < "$file"
}

__show_alias_help() {
    local _name="$1"
    local _desc="${__ALIAS_HELP_DESC[$_name]:-No description available}"
    local _code="${__ALIAS_HELP_CODE[$_name]}"

    printf "\n  \033[1;36m%s\033[0m — %s\n\n" "$_name" "$_desc"

    if [[ -n "$_code" ]]; then
        # Simple alias: show the command
        printf "  \033[2m→ %s\033[0m\n\n" "$_code"
    elif declare -f "__orig_${_name}" &>/dev/null; then
        # Wrapped function: show the original body with the real name restored
        declare -f "__orig_${_name}" | sed "s/__orig_${_name}/${_name}/" | \
            while IFS= read -r _line; do printf "  \033[2m%s\033[0m\n" "$_line"; done
        printf "\n"
    fi
}

__alias_help_wrap_alias() {
    local _name="$1"
    unalias "$_name" 2>/dev/null
    eval "$_name() { [ \"\${1:-}\" = \"--help\" ] && { __show_alias_help '$_name'; return; }; eval \"\${__ALIAS_HELP_CODE['$_name']}\" \"\$@\"; }"
}

__alias_help_wrap_function() {
    local _name="$1"
    declare -f "$_name" &>/dev/null || return
    # Skip if already wrapped
    declare -f "__orig_${_name}" &>/dev/null && return
    # Rename original function (replace name only on first line of declaration)
    eval "$(declare -f "$_name" | sed "1s/$_name/__orig_${_name}/")"
    eval "$_name() { [ \"\${1:-}\" = \"--help\" ] && { __show_alias_help '$_name'; return; }; __orig_$_name \"\$@\"; }"
}

# ── Build maps ─────────────────────────────────────────────────────────────────
__alias_help_parse "$HOME/git/environment/aliases.sh"
__alias_help_parse "$HOME/git/private-codes/private-aliases.sh"

# ── Wrap: documented names (catches functions from sourced scripts)
#         + names found directly in files (catches undocumented aliases/functions)
declare -A __ah_seen
for __ah_n in "${!__ALIAS_HELP_DESC[@]}" "${__ALIAS_HELP_NAMES[@]}"; do
    [[ -n "${__ah_seen[$__ah_n]+set}" ]] && continue
    __ah_seen["$__ah_n"]=1
    if alias "$__ah_n" &>/dev/null 2>&1; then
        __alias_help_wrap_alias "$__ah_n"
    elif declare -f "$__ah_n" &>/dev/null 2>&1; then
        __alias_help_wrap_function "$__ah_n"
    fi
done

unset __ah_n __ah_seen __ALIAS_HELP_NAMES
