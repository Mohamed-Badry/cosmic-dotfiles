# cosmic-dotfiles

Personal system configuration repository, managed via [GNU Stow](https://www.gnu.org/software/stow/). 

Built around a terminal-centric workflow and the Cosmic Epoch desktop environment on Pop!_OS.

See [DETAILS.md](DETAILS.md) for a complete list of tools, utilities, scripts, and custom keybindings.

## Setup

Requires `git` and `stow` (`sudo apt install stow`).

```bash
git clone https://github.com/your-username/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

## Structure

Packages are structured to mirror the home directory. Stow creates symlinks from these directories into `~`.

```text
~/dotfiles/
├── bash/             # .bashrc, .profile, etc.
├── cosmic/           # .config/cosmic/...
├── helix/            # .config/helix/...
├── scripts/          # .local/bin/...
└── wezterm/          # .config/wezterm/...
```

## Adding new configurations

To add a new tool (e.g., `nvim`) to the stow setup:

1. Create package structure: `mkdir -p ~/dotfiles/nvim/.config`
2. Move existing config: `mv ~/.config/nvim ~/dotfiles/nvim/.config/`
3. Symlink it: `cd ~/dotfiles && stow nvim`
4. Update script: Add `"nvim"` to the `PACKAGES` array in `install.sh`.
