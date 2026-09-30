#!/usr/bin/env bash
# Link this repo into ~ with GNU Stow. The repo mirrors ~:
#   .config/nvim/  -> ~/.config/nvim   (whole directory is one link)
#   .zshenv        -> ~/.zshenv
#   .local/bin/foo -> ~/.local/bin/foo
#
# Safe to re-run; -n for a dry run. Stow never overwrites anything: if a file
# is in the way it reports a conflict and changes nothing. It only turns a
# directory into a link if that directory doesn't exist yet, so the ones in
# REAL_DIRS are created first and always stay real directories.

set -euo pipefail
cd "$(dirname "${BASH_SOURCE[0]}")"

for f in .stowrc .stow-local-ignore; do
  [[ -f $f ]] || { echo "missing $f in $PWD, refusing to run" >&2; exit 1; }
done

REAL_DIRS=(
  "$HOME/.config"
  "$HOME/.local/bin"
  "$HOME/.local/share"
  "$HOME/.local/state/zsh"
  "$HOME/.cache/zsh"
  "$HOME/.ssh"
)

if ! command -v stow >/dev/null 2>&1; then
  echo "stow not found. Install it first: brew install stow  (Linux: sudo apt install stow)" >&2
  exit 1
fi

for d in "${REAL_DIRS[@]}"; do
  if [[ ! -d $d ]]; then
    echo "mkdir   $d"
    mkdir -p "$d"
  fi
done
chmod 700 "$HOME/.ssh"

args=(--verbose --restow --target="$HOME")
[[ ${1:-} == -n ]] && args+=(--simulate)
stow "${args[@]}" .

for f in .config/zsh/secrets.zsh .config/zsh/work.zsh; do
  [[ -e $f ]] || echo "note    $f is missing (gitignored, recreate it by hand if needed)"
done
[[ -d ${ZSH:-$HOME/.oh-my-zsh} ]] || echo "note    oh-my-zsh is not installed: https://ohmyz.sh/#install"
case ":$PATH:" in
  *":$HOME/.local/bin:"*) ;;
  *) echo "note    ~/.local/bin is not on PATH" ;;
esac
echo "done"
