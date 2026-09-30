# the actual PROMPT=... line is in .zshrc because omz loads this file before the theme
# source: https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/virtualenv/virtualenv.plugin.zsh
function virtualenv_info() {
  [[ -n "$VIRTUAL_ENV" ]] && echo "%{$fg[yellow]%}(${VIRTUAL_ENV:h:t})%{$reset_color%} "
}

# prevents stacking when activating venv (sets PS1 otherwise)
export VIRTUAL_ENV_DISABLE_PROMPT=1


