#!/usr/bin/env bash
set -e

echo "🚀 Starting full environment restore..."

# ------------------------------
# 1️⃣ Install system dependencies
# ------------------------------
echo "📦 Installing required packages..."
sudo apt update
sudo apt install -y \
  zsh tmux neovim git curl wget build-essential unzip \
  fzf bat fd-find nodejs npm

# Link Ubuntu's "batcat" and "fdfind" to standard names if missing
sudo ln -sf "$(which batcat)" /usr/local/bin/bat 2>/dev/null || true
sudo ln -sf "$(which fdfind)" /usr/local/bin/fd 2>/dev/null || true

# ------------------------------
# 2️⃣ Clone dotfiles if not present
# ------------------------------
if [ ! -d "$HOME/.dotfiles" ]; then
  echo "📂 Cloning dotfiles from GitHub..."
  git clone https://github.com/buxeyj/WSL2UbuntuDotfiles.git "$HOME/.dotfiles"
else
  echo "✅ Dotfiles already exist — skipping clone."
fi

# ------------------------------
# 3️⃣ Symlink configuration files
# ------------------------------
echo "🔗 Creating symlinks..."

ln -sf "$HOME/.dotfiles/.zshrc" "$HOME/.zshrc"
ln -sf "$HOME/.dotfiles/.config/nvim" "$HOME/.config/nvim"
ln -sf "$HOME/.dotfiles/.config/tmux" "$HOME/.config/tmux"

# Optional Zsh modular config (if you add .config/zsh/)
if [ -d "$HOME/.dotfiles/.config/zsh" ]; then
  ln -sf "$HOME/.dotfiles/.config/zsh" "$HOME/.config/zsh"
fi

# ------------------------------
# 4️⃣ Set Zsh as the default shell
# ------------------------------
if [ "$SHELL" != "$(which zsh)" ]; then
  echo "🐚 Setting Zsh as the default shell..."
  chsh -s "$(which zsh)"
else
  echo "✅ Zsh is already the default shell."
fi

# ------------------------------
# 5️⃣ Install Starship prompt
# ------------------------------
if ! command -v starship &>/dev/null; then
  echo "🌟 Installing Starship prompt..."
  curl -sS https://starship.rs/install.sh | sh -s -- -y
else
  echo "✅ Starship already installed."
fi

# ------------------------------
# 6️⃣ Final message
# ------------------------------
echo ""
echo "🎉 Restore complete!"
echo "Next steps:"
echo "1. Restart your terminal or run: exec zsh"
echo "2. Enjoy your fully configured environment 🚀"

