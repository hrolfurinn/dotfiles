# >>> aliases >>>
alias v="nvim"
alias py="python"
# alias cd="z"
alias ls="eza"
alias ll="ls -la"
alias lt="ls -aT --level=1"
alias ltt="ls -aT --level=2"
alias lttt="ls -aT --level=3"
alias agt='ag --ts --ignore lib --ignore node_modules'
alias ipython="python3 -m IPython"  # Ran into many issues surrounding this. Should solve all those problems
alias gs="git status"
# <<< aliases <<<

# >>> screensaver >>>
alias screensaver="open /System/Library/CoreServices/ScreenSaverEngine.app"
# <<< screensaver <<<

# >>> scratchpad >>>
notes() {
  mkdir -p $NOTES_DIR
  nvim $NOTES_DIR
}
scratch() {
  mkdir -p $NOTES_DIR/scratchpad
  nvim $NOTES_DIR/scratchpad/$(date +%F).md
}
scratchpad() {
  mkdir -p $NOTES_DIR/scratchpad
  nvim $NOTES_DIR/scratchpad
}
todo() {
  mkdir -p $NOTES_DIR
  nvim $NOTES_DIR/todo.md
}
notes() {
  mkdir -p ~/Documents/notes
  nvim ~/Documents/notes
}
# <<< scratchpad <<<

# >>> config shortcuts >>>
aliasconfig() {
  v ~/.oh-my-zsh/custom/aliases.zsh
  if [[ -n $VITRUAL_ENV ]]; then
    local act="$VIRTUAL_ENV/bin/activate"
    source ~/.zshrc
    source "$act"
  else
    source ~/.zshrc
  fi
}
# <<< config shortcuts <<<

# >>> functions >>>
yank() {
  cat $1 | pbcopy
}
# <<< functions <<<
