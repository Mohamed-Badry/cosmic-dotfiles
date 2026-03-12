# cosmic-dotfiles

Personal system configuration repository, managed via [GNU Stow](https://www.gnu.org/software/stow/). 

Built around a terminal-centric workflow and the Cosmic Epoch desktop environment on Pop!_OS.

See [DETAILS.md](DETAILS.md) for a complete list of tools, utilities, scripts, and custom keybindings.

## Setup

Requires `git` and `stow` (`sudo apt install stow`).

**Fonts Required:**
*   [JetBrainsMono Nerd Font](https://www.nerdfonts.com/)
*   [FiraCode Nerd Font](https://www.nerdfonts.com/)

**Note on Wallpapers & Absolute Paths:**
The install script will automatically replace hardcoded paths to `/home/crim` in the Cosmic configurations with your local `$HOME` path. Wallpapers are included in the repository and will be automatically stowed to `~/.local/share/backgrounds/`. If they do not appear immediately, you may need to re-select them in your Cosmic Appearance settings or log out and back in to refresh the desktop session.

```bash
git clone https://github.com/Mohamed-Badry/cosmic-dotfiles.git ~/cosmic-dotfiles
cd ~/cosmic-dotfiles
./install.sh
```

## Structure

Packages are structured to mirror the home directory. Stow creates symlinks from these directories into `~`.

```text
~/cosmic-dotfiles/
├── bash/             # .bashrc, .profile, etc.
├── cosmic/           # .config/cosmic/...
├── helix/            # .config/helix/...
├── scripts/          # .local/bin/...
└── wezterm/          # .config/wezterm/...
```

## Adding new configurations

To add a new tool (e.g., `nvim`) to the stow setup:

1. Create package structure: `mkdir -p ~/cosmic-dotfiles/nvim/.config`
2. Move existing config: `mv ~/.config/nvim ~/cosmic-dotfiles/nvim/.config/`
3. Symlink it: `cd ~/cosmic-dotfiles && stow nvim`
4. Update script: Add `"nvim"` to the `PACKAGES` array in `install.sh`.
