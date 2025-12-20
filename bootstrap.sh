#!/bin/bash
set -e

DOTFILES_REPO="git@github.com:msrband/dotfiles.git"
DOTFILES_DIR="$HOME/.dotfiles"

echo "==> Starting dotfiles bootstrap..."

# 1. Install Homebrew if not present
if ! command -v brew &> /dev/null; then
    echo "==> Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Add Homebrew to PATH for Apple Silicon
    if [[ $(uname -m) == "arm64" ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
else
    echo "==> Homebrew already installed"
fi

# 2. Clone dotfiles bare repository
if [[ -d "$DOTFILES_DIR" ]]; then
    echo "==> Dotfiles already cloned"
else
    echo "==> Cloning dotfiles..."
    git clone --bare "$DOTFILES_REPO" "$DOTFILES_DIR"
fi

# Helper function for dotfiles git commands
dotfiles() {
    git --git-dir="$DOTFILES_DIR" --work-tree="$HOME" "$@"
}

# 3. Checkout dotfiles
echo "==> Checking out dotfiles..."
if ! dotfiles checkout 2>/dev/null; then
    echo "==> Backing up conflicting files..."
    mkdir -p "$HOME/.dotfiles-backup"
    dotfiles checkout 2>&1 | grep -E "^\s+" | awk '{print $1}' | while read -r file; do
        mkdir -p "$HOME/.dotfiles-backup/$(dirname "$file")"
        mv "$HOME/$file" "$HOME/.dotfiles-backup/$file"
    done
    dotfiles checkout
fi

# Hide untracked files in dotfiles status
dotfiles config --local status.showUntrackedFiles no

# 4. Install Homebrew packages
echo "==> Installing Homebrew packages..."
brew bundle --file="$HOME/Brewfile"

# 5. Install mise tools
echo "==> Installing mise tools..."
if command -v mise &> /dev/null; then
    mise install
else
    echo "Warning: mise not found. Run 'brew install mise' first, then 'mise install'"
fi

echo "==> Bootstrap complete!"
echo ""
echo "Next steps:"
echo "  1. Restart your shell or run: source ~/.zshrc"
echo "  2. Configure app-specific settings as needed"
