export NVM_DIR="$HOME/.nvm"
export GOENV_ROOT="$HOME/.goenv"
export PATH="$GOENV_ROOT/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

if [ -s "$NVM_DIR/nvm.sh" ]; then
	. "$NVM_DIR/nvm.sh"
fi

if [ -s "$NVM_DIR/bash_completion" ]; then
	. "$NVM_DIR/bash_completion"
fi

if command -v goenv >/dev/null 2>&1; then
	eval "$(goenv init -)"
fi

alias vi='nvim'
alias vim='nvim'
