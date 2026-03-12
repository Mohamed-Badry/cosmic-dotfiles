# Dotfiles Management Plan

## 1. Context & Status
- **Goal:** Manage and backup dotfiles to a GitHub repository using a "set and forget" approach.
- **Current Task:** Initial setup and migration of existing configuration files into a Git repository.
- **Next Steps:** Migrate files to the `~/dotfiles` repository, setup GNU Stow, create an installation script, and push to GitHub.

## 2. Technical Decisions (ADRs)
- **Method:** **GNU Stow**
- **Why GNU Stow?**
  - **Set and Forget:** Once a configuration is "stowed" (symlinked), you edit your config files in `~/.config/` exactly as you always have. The changes automatically reflect in the `~/dotfiles` repository because they are symlinks. No need to remember special commands like `chezmoi edit`.
  - **Modular:** Looking at your `~/.config` folder, you have many distinct applications (`wezterm`, `zellij`, `helix`, `btop`, `starship`). Stow allows us to group these into "packages" (e.g., a `wezterm` folder, a `zellij` folder). This means on a server, you could just stow `bash` and `helix`, but on your desktop, you stow everything.
  - **Scriptable Setup:** We can easily write a simple `install.sh` script that automatically runs `stow` for all packages on a new machine.

## 3. Development Commands
- **Stow a package:** `stow <package_name>` (e.g., `stow wezterm`)
- **Unstow a package:** `stow -D <package_name>`
- **Backup to GitHub:**
  ```bash
  cd ~/dotfiles
  git add .
  git commit -m "Update dotfiles"
  git push
  ```

## 4. Architecture Overview (Stow Structure)
The repository `~/dotfiles` will be structured where each top-level directory is a "package" that mimics the home directory structure inside it.

```text
~/dotfiles/
├── bash/
│   ├── .bashrc
│   ├── .bash_logout
│   └── .profile
├── git/
│   └── .gitconfig
├── wezterm/
│   └── .config/
│       └── wezterm/
│           └── wezterm.lua
├── zellij/
│   └── .config/
│       └── zellij/
├── helix/
│   └── .config/
│       └── helix/
├── starship/
│   └── .config/
│       ├── starship.toml
│       └── starship-vscode.toml
└── install.sh (Automates the stow process for new machines)
```

## 5. Execution Steps

### Phase 1: Preparation
1. Install GNU Stow (`sudo apt install stow` or equivalent).
2. Initialize `~/dotfiles` as a Git repository.

### Phase 2: Migration (The core task)
1. Create package directories in `~/dotfiles` (e.g., `bash`, `wezterm`, `zellij`, `helix`, `starship`, `git`).
2. Move the actual config files from `~` and `~/.config` into their respective package directories in `~/dotfiles`, maintaining the directory structure (e.g., move `~/.config/wezterm` to `~/dotfiles/wezterm/.config/wezterm`).
3. Use Stow to create symlinks back to the original locations (`cd ~/dotfiles && stow wezterm`).

### Phase 3: Automation & Backup
1. Write an `install.sh` script in `~/dotfiles` that iterates through the directories and runs `stow` on them.
2. Commit all changes to Git.
3. (User Action) Create a GitHub repository and push the local `~/dotfiles` repository to it.