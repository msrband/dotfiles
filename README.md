# dotfiles

Personal dotfiles managed with a bare Git repository.

## Quick Start

Run the bootstrap script on a fresh macOS machine:

```bash
curl -fsSL https://raw.githubusercontent.com/msrband/dotfiles/main/bootstrap.sh | bash
```

Or manually:

```bash
git clone --bare git@github.com:msrband/dotfiles.git ~/.dotfiles
alias dotfiles='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
dotfiles checkout
dotfiles config --local status.showUntrackedFiles no
brew bundle --file=~/Brewfile
mise install
```

## What's Included

| Category | Tools |
|----------|-------|
| Shell | zsh, powerlevel10k, autojump, fzf |
| Editor | neovim (LazyVim), ideavim |
| Terminal | ghostty, tmux |
| Version Manager | mise (node, python) |
| Git | git, gh, gitui, lazygit, tig |

## Structure

```
~
├── .config/
│   ├── ghostty/      # Terminal config
│   ├── mise/         # Runtime version manager
│   └── nvim/         # Neovim config (LazyVim)
├── .claude/          # Claude Code settings
├── .zshrc            # Zsh config
├── .tmux.conf        # Tmux config
├── .ideavimrc        # IdeaVim config
├── Brewfile          # Homebrew packages
└── bootstrap.sh      # Setup script
```

## Managing Dotfiles

```bash
# Add the alias to your shell (already in .zshrc)
alias dotfiles='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'

# Usage
dotfiles status
dotfiles add ~/.config/some/file
dotfiles commit -m "Add config"
dotfiles push
```

## License

MIT
