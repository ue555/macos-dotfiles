#!/usr/bin/env bash

set -euo pipefail

DOTFILES_DIR="${DOTFILES_DIR:-$HOME/dotfiles}"
NVIM_SOURCE="$DOTFILES_DIR/lazy.nvim/nvim"
NVIM_TARGET="$HOME/.config/nvim"
WEZTERM_SOURCE="$DOTFILES_DIR/.wezterm.lua"
WEZTERM_TARGET="$HOME/.wezterm.lua"
ZPROFILE_SOURCE="$DOTFILES_DIR/.zprofile"
ZPROFILE_TARGET="$HOME/.zprofile"
ZSHRC_SOURCE="$DOTFILES_DIR/.zshrc"
ZSHRC_TARGET="$HOME/.zshrc"
export NVM_DIR="${NVM_DIR:-$HOME/.nvm}"

mkdir -p "$DOTFILES_DIR"
mkdir -p "$HOME/.config"

if [ ! -f "$ZPROFILE_SOURCE" ]; then
	cat <<'EOF' > "$ZPROFILE_SOURCE"
eval "$(/opt/homebrew/bin/brew shellenv zsh)"
EOF
fi

if [ ! -f "$ZSHRC_SOURCE" ]; then
	cat <<'EOF' > "$ZSHRC_SOURCE"
export NVM_DIR="$HOME/.nvm"

if [ -s "$NVM_DIR/nvm.sh" ]; then
	. "$NVM_DIR/nvm.sh"
fi

if [ -s "$NVM_DIR/bash_completion" ]; then
	. "$NVM_DIR/bash_completion"
fi
EOF
fi

if [ -e "$ZPROFILE_TARGET" ] && [ ! -L "$ZPROFILE_TARGET" ]; then
	mv "$ZPROFILE_TARGET" "$ZPROFILE_TARGET.bak"
fi

if [ -e "$ZSHRC_TARGET" ] && [ ! -L "$ZSHRC_TARGET" ]; then
	mv "$ZSHRC_TARGET" "$ZSHRC_TARGET.bak"
fi

if [ -e "$WEZTERM_TARGET" ] && [ ! -L "$WEZTERM_TARGET" ]; then
	mv "$WEZTERM_TARGET" "$WEZTERM_TARGET.bak"
fi

if [ -e "$NVIM_TARGET" ] && [ ! -L "$NVIM_TARGET" ]; then
	mv "$NVIM_TARGET" "$NVIM_TARGET.bak"
fi

ln -sfn "$ZPROFILE_SOURCE" "$ZPROFILE_TARGET"
ln -sfn "$ZSHRC_SOURCE" "$ZSHRC_TARGET"
ln -sfn "$WEZTERM_SOURCE" "$WEZTERM_TARGET"
ln -sfn "$NVIM_SOURCE" "$NVIM_TARGET"

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

brew install chromium
brew install firefox
brew install gh
brew install goenv
brew install neovim
brew install opera
brew install slack
brew install --cask brave-browser
brew install --cask codex
brew install --cask microsoft-edge
brew install vivaldi
xattr -cr /Applications/Chromium.app

curl -fsSL https://claude.ai/install.sh | bash

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.4/install.sh | bash

if [ ! -s "$NVM_DIR/nvm.sh" ]; then
	echo "nvm installation did not complete successfully." >&2
	exit 1
fi

. "$NVM_DIR/nvm.sh"

nvm install --lts
nvm alias default 'lts/*'
nvm use default
