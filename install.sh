
#!/bin/bash

# Get the absolute path of the directory where this script resides
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="$HOME/.config"

echo "🛠️ Installing dotfiles from: $DOTFILES_DIR"
echo

# Ensure ~/.config exists
mkdir -p "$CONFIG_DIR"

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

    ln -s "$item" "$dest"
    echo "✅ Linked $name → $dest"
  else
    echo "⏭️  Skipped $name"
  fi

  echo
done

echo "🎉 All done!"

