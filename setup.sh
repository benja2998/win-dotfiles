#!/usr/bin/env bash

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

# Neovim config directory
NVIM_CONFIG="$HOME/.config/nvim"

# Create config directory if it doesn't exist
if [ ! -d "$NVIM_CONFIG" ]; then
    echo "Creating Neovim config directory..."
    mkdir -p "$NVIM_CONFIG"
fi

# Create symlink for init.lua
if [ -e "$NVIM_CONFIG/init.lua" ]; then
    echo "init.lua already exists, skipping..."
else
    ln -s "$DOTFILES_DIR/init.lua" "$NVIM_CONFIG/init.lua"
    echo "Symlink for init.lua created."
fi

echo "Neovim setup complete."
