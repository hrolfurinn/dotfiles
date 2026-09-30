export FPATH="/Users/ralo/src/eza/completions/zsh:$FPATH"

export PATH="$PATH:$HOME/.elan/bin"
if command -v go &>/dev/null
then
 export PATH="$PATH:$(go env GOPATH)/bin" 
fi
