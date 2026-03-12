# Dotfiles Management Plan

## 1. Context & Status
- **Goal:** Manage and backup dotfiles to a GitHub repository using a "set and forget" approach.
- **Current Task:** Maintenance, expanding stowed packages, and documenting the workflow for future additions.
- **Status:** Initial migration is complete. GNU Stow is set up to manage packages. An `install.sh` script is functional and includes dynamic path resolution for hardcoded Cosmic configurations.

## 2. Technical Decisions (ADRs)
- **Method:** **GNU Stow**
- **Why GNU Stow?**
  - **Set and Forget:** Once a configuration is "stowed" (symlinked), editing config files in `~/.config/` directly updates the repository.
  - **Modular:** Configurations are grouped into "packages" (e.g., `wezterm`, `zellij`, `fastfetch`), allowing selective installation on different machines.
- **Handling Absolute Paths:**
  - Some applications (like Cosmic Epoch desktop components) do not support `~` expansion for paths (e.g., wallpapers, favorites) and require absolute paths like `/home/crim/...`.
  - **Solution:** We store the absolute paths pointing to `/home/crim` in the repo, but the `install.sh` script automatically uses `sed` to replace `/home/crim` with the current user's `$HOME` variable when setting up a new machine.

## 3. Development Commands
- **Stow a package:** `cd ~/dotfiles && stow <package_name>`
- **Unstow a package:** `cd ~/dotfiles && stow -D <package_name>`
- **Backup to GitHub:**
  ```bash
  cd ~/dotfiles
  git add .
  git commit -m "Update dotfiles"
  git push
  ```

## 4. Architecture Overview (Stow Structure)
The repository `~/dotfiles` is structured where each top-level directory is a "package" that mimics the home directory structure inside it.

```text
~/dotfiles/
├── bash/             # bash configurations
├── btop/             # btop configuration
├── cosmic/           # Cosmic Epoch desktop config
├── fastfetch/        # fastfetch configuration
├── fuzzel/           # fuzzel application launcher config
├── helix/            # helix text editor config
├── rofi/             # rofi launcher config
├── scripts/          # custom user scripts (.local/bin)
├── starship/         # starship prompt config
├── vscode/           # VSCode user settings
├── wallpapers/       # desktop wallpapers (.local/share/backgrounds)
├── wezterm/          # wezterm terminal config
├── zellij/           # zellij multiplexer config
├── install.sh        # Automates the stow process and path translation
└── README.md
```

## 5. Standard Operating Procedure (SOP) for Adding a New Package
**Attention Gemini:** When the user requests to back up a new tool or configuration, STRICTLY follow these steps:

1. **Verify Existence:** Check if the configuration directory/file exists in the user's home directory.
2. **Audit for Secrets & Paths:** 
   - Inspect the configuration files.
   - **CRITICAL:** Ensure NO API keys, passwords, or sensitive tokens are included.
   - Identify if there are any hardcoded absolute paths (like `/home/crim/...`). If so, determine if the tool supports `~` or `$HOME` expansion and update it. If it strictly requires absolute paths (like Cosmic), ensure `install.sh` is capable of translating it during setup.
3. **Create Package Structure:** Create the corresponding Stow package directory structure in `~/dotfiles`.
   - *Example:* For `~/.config/nvim`, create `~/dotfiles/nvim/.config/`.
4. **Copy Configurations:** Copy the configurations from the home directory to the new package directory.
5. **Remove Original & Stow:**
   - **CRITICAL:** You must delete the original configuration directory from `~/.config/` (or `~`) before running `stow`. Stow will fail if a real directory or file already exists at the target symlink location.
   - Run `stow <package_name>` from the `~/dotfiles` directory.
6. **Update Installer:** Add the new package name to the `PACKAGES` array in `~/dotfiles/install.sh`.
7. **Update Documentation:** Update the directory tree in `~/dotfiles/README.md` to reflect the newly managed package.
