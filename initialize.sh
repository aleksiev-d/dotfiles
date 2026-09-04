#!/usr/bin/env bash

CONFIG_DIR="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" && pwd)"

# MacOs Vs_Code path
VSCODE_USER_DIR="$HOME/Library/Application Support/Code/User"

# Linux Vs_Code path
# VSCODE_USER_DIR=~/.config/Code/User

have()    { command -v "$1" >/dev/null 2>&1; }
confirm() { read -r -p "$1 [y/N] " reply; [[ "$reply" =~ ^[Yy]$ ]]; }
link_file() { rm -f "$1"; ln -s "$2" "$1"; }
link_dir()  { rm -rf "$1"; ln -s "$2" "$1"; }

# Installs Homebrew itself if it's missing, and makes it available on PATH
# for the rest of this script's run. Returns failure if brew still isn't
# available afterward (install declined or failed).
ensure_brew() {
  have brew && return 0

  confirm "Homebrew is not installed. Install it now?" || return 1

  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  if [ -x /opt/homebrew/bin/brew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [ -x /usr/local/bin/brew ]; then
    eval "$(/usr/local/bin/brew shellenv)"
  fi

  have brew
}

# Runs the check -> (offer install) -> link flow for a single tool.
setup_tool() {
  local name="$1" check_fn="$2" install_fn="$3" link_fn="$4"

  confirm "Set up $name configuration?" || { echo "Skipping $name."; return; }

  if ! "$check_fn"; then
    if confirm "$name is not installed. Install it now via Homebrew?"; then
      if ensure_brew; then
        "$install_fn"
      else
        echo "Homebrew is required to install $name automatically — install $name manually, then re-run this script."
      fi
    fi
    if ! "$check_fn"; then
      echo "Skipping $name configuration (still not installed)."
      return
    fi
  fi

  "$link_fn"
}

check_vscode()   { have code; }
install_vscode() { brew install --cask visual-studio-code; }
link_vscode() {
  echo "Setting up VS Code keybindings..."
  link_file "$VSCODE_USER_DIR/keybindings.json" "$CONFIG_DIR/vscode/keybindings.json"

  echo "Setting up VS Code settings..."
  link_file "$VSCODE_USER_DIR/settings.json" "$CONFIG_DIR/vscode/settings.json"

  echo "Installing VS Code extensions..."
  while IFS= read -r extension || [ -n "$extension" ]; do
    if [ -n "$extension" ]; then
      echo "Installing $extension..."
      code --install-extension "$extension"
    fi
  done <"$CONFIG_DIR/vscode/extensions.txt"
  echo "VS Code extensions installation complete!"
}

check_zsh()   { have zsh; }
install_zsh() { brew install zsh; }
link_zsh() {
  echo "Setting up zsh configuration..."
  link_file "$HOME/.zshrc" "$CONFIG_DIR/zshrc/.zshrc"
}

check_rider()   { have rider || [ -d "/Applications/Rider.app" ]; }
install_rider() { brew install --cask rider; }
link_rider() {
  echo "Setting up IdeaVim configuration..."
  link_file "$HOME/.ideavimrc" "$CONFIG_DIR/rider/.ideavimrc"
}

check_nvim()   { have nvim; }
install_nvim() { brew install neovim; }
link_nvim() {
  echo "Setting up Neovim configuration..."
  # -rf because the target is a directory (or an old symlink) on a fresh machine
  link_dir "$HOME/.config/nvim" "$CONFIG_DIR/nvim"
}

check_kitty()   { have kitty || [ -d "/Applications/kitty.app" ]; }
install_kitty() { brew install --cask kitty; }
link_kitty() {
  echo "Setting up kitty configuration..."
  link_dir "$HOME/.config/kitty" "$CONFIG_DIR/kitty"
}

check_aerospace()   { have aerospace || [ -d "/Applications/AeroSpace.app" ]; }
install_aerospace() { brew install --cask nikitabobko/tap/aerospace; }
link_aerospace() {
  echo "Setting up AeroSpace configuration..."
  link_file "$HOME/.aerospace.toml" "$CONFIG_DIR/aerospace/.aerospace.toml"
}

check_lazygit()   { have lazygit; }
install_lazygit() { brew install lazygit; }
link_lazygit() {
  echo "Setting up lazygit configuration..."
  # Only config.yml is linked; lazygit writes state.yml alongside it, which is machine-local.
  mkdir -p "$HOME/Library/Application Support/lazygit"
  link_file "$HOME/Library/Application Support/lazygit/config.yml" "$CONFIG_DIR/lazygit/config.yml"
}

setup_tool "VS Code"          check_vscode     install_vscode     link_vscode
setup_tool "zsh"              check_zsh        install_zsh        link_zsh
setup_tool "Rider (IdeaVim)"  check_rider      install_rider      link_rider
setup_tool "Neovim"           check_nvim       install_nvim       link_nvim
setup_tool "kitty"            check_kitty      install_kitty      link_kitty
setup_tool "AeroSpace"        check_aerospace  install_aerospace  link_aerospace
setup_tool "lazygit"          check_lazygit    install_lazygit    link_lazygit
