_git_checkout_complete() {
  # Get current word
  local current_word="${COMP_WORDS[COMP_CWORD]}"
  # Get list of branches
  local branches=$(git branch --list "${current_word}*" | sed 's/\*//g' | awk '{$1=$1};1')
  # Set completions to available branches
  COMPREPLY=($(compgen -W "$branches" -- "$current_word"))
}

complete -o default -F _git_checkout_complete gco
complete -o default -F _git_checkout_complete gbd
complete -o default -F _git_checkout_complete gbD