#!/usr/bin/env bash

# Dotfiles installation script

# Ensure the script is run from the dotfiles directory
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$DIR"

# Check if stow is installed
if ! command -v stow &> /dev/null; then
    echo "Error: GNU stow is not installed."
    echo "Please install it using your package manager (e.g., sudo apt install stow) and try again."
    exit 1
fi

echo "Stowing configurations..."

# Define the list of packages to stow
PACKAGES=(
    "bash"
    "wezterm"
    "zellij"
    "helix"
    "starship"
    "btop"
    "rofi"
    "cosmic"
    "vscode"
    "rustup"
    "scripts"
)

for pkg in "${PACKAGES[@]}"; do
    if [ -d "$pkg" ]; then
        echo "Stowing $pkg..."
        stow "$pkg"
    else
        echo "Warning: Package directory '$pkg' not found, skipping."
    fi
done

echo "Dotfiles successfully stowed!"
