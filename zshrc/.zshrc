for brew_bin in /opt/homebrew/bin/brew /usr/local/bin/brew /home/linuxbrew/.linuxbrew/bin/brew; do
  if [ -x "$brew_bin" ]; then
    eval "$("$brew_bin" shellenv)"
    break
  fi
done
unset brew_bin

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="simple"

plugins=(
    git
    dotnet
    zsh-autosuggestions
   # zsh-syntax-highlighting
   # zsh-vi-mode
)

HISTFILE=~/.zsh_history
HISTORY_IGNORE="(ls|cd|pwd|cp|mv|rm|mkdir)"
HISTSIZE=10000
SAVEHIST=10000

setopt appendhistory
setopt EXTENDED_HISTORY          # Write the history file in the ':start:elapsed;command' format.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire a duplicate event first when trimming history.
setopt HIST_FIND_NO_DUPS         # Do not display a previously found event.
setopt HIST_IGNORE_ALL_DUPS      # Delete an old recorded event if a new event is a duplicate.
setopt HIST_IGNORE_DUPS          # Do not record an event that was just recorded again.
setopt HIST_IGNORE_SPACE         # Do not record an event starting with a space.
setopt HIST_SAVE_NO_DUPS         # Do not write a duplicate event to the history file.
setopt SHARE_HISTORY             # Share history between all sessions.

[ -f "$ZSH/oh-my-zsh.sh" ] && source "$ZSH/oh-my-zsh.sh"

export FZF_DEFAULT_OPTS=" \
--reverse"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

[ -f "$HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ] && source "$HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
export PATH="$HOME/.local/bin:$PATH"
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
export PATH="/opt/nvim/bin:$PATH"
alias python=python3
alias pip=pip3

# Auto-copies kitty's terminfo to the remote host on connect, so backspace
# and friends work even on machines that don't know about xterm-kitty.
[ "$TERM" = "xterm-kitty" ] && command -v kitty >/dev/null 2>&1 && alias ssh="kitty +kitten ssh"

[ -f "/Users/danailaleksiev/.ghcup/env" ] && . "/Users/danailaleksiev/.ghcup/env" # ghcup-env

# Self-heal a terminal left in mouse-reporting mode. A TUI that dies with the
# connection (herdr over a dropped ssh) never sends its disable sequence, so
# kitty keeps reporting every mouse move and the shell echoes them as
# "35;61;20M" garbage. Turn the modes off before drawing each prompt, so any
# stale session is cleared by pressing Enter. Order: X10, button, any-motion
# tracking, then the SGR and urxvt encodings.
_disable_stale_mouse_reporting() { print -n '\e[?1000l\e[?1002l\e[?1003l\e[?1006l\e[?1015l' }
autoload -Uz add-zsh-hook
add-zsh-hook precmd _disable_stale_mouse_reporting
