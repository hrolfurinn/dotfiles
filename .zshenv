# This is and should be the only zsh file in ~ (symlinked). 
# zsh reads everything else from $ZDOTDIR.
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export DOTFILES="$HOME/src/dotfiles"

# export SHELL_SESSIONS_DISABLE=1   # uncomment to stop Terminal.app's per-tab session files

. "$HOME/.cargo/env"
