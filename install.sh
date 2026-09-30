#!/usr/bin/env bash
# Symlink these dotfiles into place with GNU Stow. Safe to re-run.
#
#   config/  -> $XDG_CONFIG_HOME  one link per top-level entry (nvim, zsh, ...)
#   home/    -> ~                 one link per FILE (--no-folding), so real
#                                 dirs like ~/.ssh or ~/.local/bin never turn
#                                 into links into this repo
#
# Stow never overwrites anything: if a file is in the way it reports a
# conflict and changes nothing. Run with -n for a dry run.
# Use this script rather than calling stow by hand, since the flags matter.

set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
DRY_RUN=0
[[ ${1:-} == -n ]] && DRY_RUN=1

if ! command -v stow >/dev/null 2>&1; then
  echo "stow not found. Install it first: brew install stow  (Linux: sudo apt install stow)" >&2
  exit 1
fi

args=(--verbose --dir="$DOTFILES" --ignore='\.DS_Store' --restow)
if (( DRY_RUN )); then
  args+=(--simulate)
  echo "dry run: nothing will change"
fi

echo "==> config/ -> $CONFIG_HOME"
(( DRY_RUN )) || mkdir -p "$CONFIG_HOME"
stow "${args[@]}" --target="$CONFIG_HOME" config

if [[ -d $DOTFILES/home ]]; then
  echo "==> home/ -> ~"
  stow "${args[@]}" --target="$HOME" --no-folding home
fi

if (( ! DRY_RUN )); then
  mkdir -p "${XDG_STATE_HOME:-$HOME/.local/state}/zsh" "${XDG_CACHE_HOME:-$HOME/.cache}/zsh"
fi

echo "==> checks"
for f in config/zsh/secrets.zsh config/zsh/work.zsh; do
  [[ -e $DOTFILES/$f ]] || echo "note: $f is missing (gitignored, recreate it by hand if needed)"
done
[[ -d ${ZSH:-$HOME/.oh-my-zsh} ]] || echo "note: oh-my-zsh is not installed: https://ohmyz.sh/#install"
if [[ -d $DOTFILES/home/.local/bin ]]; then
  case ":$PATH:" in
    *":$HOME/.local/bin:"*) ;;
    *) echo "note: ~/.local/bin is not on PATH" ;;
  esac
fi
echo "done"
