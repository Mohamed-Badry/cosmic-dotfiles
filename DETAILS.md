# System Snapshot & Workflow

A reference list of installed tools, CLI utilities, and custom scripts/keybindings configured in the cosmic-dotfiles repository.

## Core Stack

*   **Manager:** [GNU Stow](https://www.gnu.org/software/stow/)
*   **Shell:** Bash (`.bashrc`, `.profile`, `.inputrc`, `.dircolors`)
*   **Desktop:** [Cosmic Epoch](https://github.com/pop-os/cosmic-epoch) (Panel layouts, custom "Cosmic Red" themes, window rules)
*   **Launchers/Pickers:** [Rofi](https://github.com/davatorium/rofi), [Fuzzel](https://codeberg.org/dnkl/fuzzel)
*   **Terminal:** [WezTerm](https://wezfurlong.org/wezterm/) (GPU-accelerated, Lua config)
*   **Multiplexer:** [Zellij](https://zellij.dev/)
*   **Prompt:** [Starship](https://starship.rs/)
*   **Monitor:** [Btop](https://github.com/aristocratos/btop)
*   **Editors:** [Helix](https://helix-editor.com/) and [VSCode](https://code.visualstudio.com/) (using custom "Cosmic Red" themes inherited from Horizon Dark), [Zed](https://zed.dev/)
*   **VCS:** Git, [jj](https://github.com/martinvonz/jj)

## CLI Utilities (Installed separately)

### Rust Ecosystem (`cargo binstall`)
*   **Core Utils:** `bat` (cat), `eza` (ls), `zoxide` (cd), `dua` (disk usage), `sk` (fuzzy finder)
*   **Dev:** `just`, `taplo`, `typst`, `tinymist`
*   **System/Media:** `yazi`, `termusic`, `termusic-server`, `statui`, `weathr`, `netwatch`, `oxipng`
*   **AI:** `gemini-watermark`, `llmfit`
*   **Cargo:** `cargo-binstall`, `cargo-install-update`

### Python Ecosystem (`uv tool install`)
*   **Tools:** `ruff`, `jupytext`, `marimo`, `pyrasite`, `py-spy`, `yt-dlp`

## GUI Apps
*   **Browser:** [Zen Browser](https://zen-browser.app/)
*   **Flatpaks:** Chromium, Heroic Games Launcher, Camera

---

## Custom Keybindings

The following shortcuts are custom additions implemented on top of the default Cosmic Epoch keybindings. They rely on the shell scripts backed up in `scripts/.local/bin/`.

### Clipboard (Fuzzel + Cliphist)
*   **`Super + V` (Toggle):** Kills Fuzzel if open; otherwise pipes `cliphist list` to `fuzzel --dmenu` and copies selection via `wl-copy`.
*   **`Super + Shift + V` (Manage):** Opens a dedicated menu to delete specific cliphist entries or wipe history entirely.

### Media (`smart-playerctl`)
Controls target the *active* or *most recent* media player rather than sending commands to all open players simultaneously.
*   **`Super + X`:** Play/Pause Active Media
*   **`Super + C`:** Next Track
*   **`Super + Z`:** Previous Track
*   **`Super + Shift + X`:** Cycle active player target (e.g., switch control from Spotify to Zen Browser).

### Utilities
*   **`Super + Shift + C`:** Launch Python color picker.
*   **`Super + \`` [Grave]:** Toggle Dropdown Scratchpad. Spawns/hides a floating WezTerm instance running a persistent Zellij session named `scratchpad`.
*   **`Super + Shift + PrintScreen`:** Toggle OBS Recording. Silently starts/stops recording via websockets using an isolated `uv` python environment.

### Window Management (Vim-style)
*   **`Super + h / j / k / l`:** Focus windows Left, Down, Up, Right.
*   **`Super + Shift + S`:** Swap current window.
*   **`Super + P`:** Toggle sticky state.
