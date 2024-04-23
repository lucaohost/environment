c() {
    cd $LUCAO_ENV && cd ..
    directory=$1
    if [ -n "$directory" ]; then
        cd $directory
    fi
}

_code_dir_complete() {
  # Get current word
  local current_word="${COMP_WORDS[COMP_CWORD]}"
  current_word="${current_word%/}"
  local directory=$(dirname "$LUCAO_ENV")
  local directories=$(find "$directory" -maxdepth 1 -mindepth 1 -type d -name "${current_word}*" -exec basename {} \;)
  # Set completions to available directories
  COMPREPLY=($(compgen -W "$directories" -- "$current_word"))
}

complete -o default -F _code_dir_complete c
