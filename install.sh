
#!/bin/bash

# Get the absolute path of the directory where this script resides
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="$HOME/.config"

echo "🛠️ Installing dotfiles from: $DOTFILES_DIR"
echo

# Ensure ~/.config exists
mkdir -p "$CONFIG_DIR"


echo "Linking zsh files..."
#ln -sf "$SOURCE_DIR/.zshrc" "$HOME/.zshrc"
#ln -sf "$SOURCE_DIR/.zshenv" "$HOME/.zshenv"

ln -sf $(pwd)/.zshrc ~/.zshrc
ln -sf $(pwd)/.zshenv ~/.zshenv

Echo "Linking vim files..."
ln -sf $(pwd)/.vimrc ~/.vimrc

# Loop through every item in the dotfiles directory
for item in "$DOTFILES_DIR"/*; do
  name=$(basename "$item")

  # Destination path in ~/.config
  dest="$CONFIG_DIR/$name"

  # Ask for confirmation
  echo "📦 Found: $name"
  read -p "→ Symlink to $dest? [y/N] " answer



  if [[ "$answer" == [Yy]* ]]; then
    if [ -e "$dest" ] || [ -L "$dest" ]; then
      echo "⚠️  Removing existing $dest"
      rm -rf "$dest"
    fi

    stow $name
    echo "✅ Linked $name → $dest"
  else
    echo "⏭️  Skipped $name"
  fi

  echo
done

echo "🎉 All done!"

# Arch only
echo "Using pacman to install stuff..."
echo "Downloading font"

sudo pacman -S ttf-jetbrains-mono-nerd kitty

echo "Downloading vim stuff"
sudo pacman -S git vim ripgrep fd fzf rust-analyzer

echo "Downloading i3 stuff"
sudo pacman -S maim polybar flameshot picom rofi

echo "Downloading hyprland stuff"
sudo pacman -S wofi hyprland hyprpaper hyprlock mako waybar grim wl-copy
