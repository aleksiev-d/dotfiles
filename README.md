# configurations

Personal dotfiles. The real configuration files live in this repo; the
locations where each tool expects its config are symbolic links pointing back
here. Editing a config through either path edits the same file, so changes are
always visible to `git status` — the repo is the single source of truth.

## Structure

```
configurations/
├── initialize.sh   # bootstrap script: plants all symlinks, installs VS Code extensions
├── zshrc/          # .zshrc
├── rider/          # .ideavimrc (IdeaVim, used by Rider)
├── vscode/         # settings.json, keybindings.json, extensions.txt
├── nvim/           # full Neovim config (LazyVim): init.lua, lua/config, lua/plugins, lazy-lock.json
├── lazygit/        # config.yml (delta as the diff pager)
└── iterm2/         # iTerm2 color presets (.itermcolors)
```

## What initialize.sh does

For each managed config it removes whatever occupies the canonical location
and replaces it with a symlink into this repo:

| Link (where the tool looks)                                    | Real file (in this repo)  |
| --------------------------------------------------------------| ------------------------- |
| `~/.zshrc`                                                     | `zshrc/.zshrc`            |
| `~/.ideavimrc`                                                 | `rider/.ideavimrc`        |
| `~/Library/Application Support/Code/User/settings.json`        | `vscode/settings.json`    |
| `~/Library/Application Support/Code/User/keybindings.json`     | `vscode/keybindings.json` |
| `~/.config/nvim` (whole directory)                             | `nvim/`                   |
| `~/Library/Application Support/lazygit/config.yml`             | `lazygit/config.yml`      |

It then installs every VS Code extension listed in `vscode/extensions.txt`
via `code --install-extension`.

The script is idempotent — rerunning it just recreates identical links, so it
also works as a repair tool if a link gets clobbered.

## Setting up a new machine

```sh
git clone git@github.com:aleksiev-d/dotfiles.git ~/Documents/configurations
cd ~/Documents/configurations
./initialize.sh
```

Manual steps not covered by the script:

- **iTerm2 colors**: `open "iterm2/Everforest Dark Soft.itermcolors"` to import
  the preset, then apply it in Settings → Profiles → Colors → Color Presets.
  (iTerm2 copies preset values into its own preferences, so symlinking is not
  applicable here.)
- **lazygit pager**: the config sets `delta` as the diff pager, so install it
  (`brew install git-delta`) or lazygit falls back to plain diffs.
- **Neovim plugins**: nothing to do — the first `nvim` launch bootstraps
  lazy.nvim and installs the exact plugin versions pinned in
  `nvim/lazy-lock.json`.

## Notes

- The script targets macOS paths (VS Code under `~/Library/Application Support`);
  the Linux path is present but commented out in `initialize.sh`.
- Machine-local state is intentionally not in this repo: Neovim's plugin
  clones and state live in `~/.local/share/nvim` / `~/.local/state/nvim`,
  and `nvim/.claude/` is gitignored.
