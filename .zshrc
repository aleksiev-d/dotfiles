export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="simple"

plugins=(
    git
    dotnet
    zsh-autosuggestions
    zsh-syntax-highlighting
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

source $ZSH/oh-my-zsh.sh

export FZF_DEFAULT_OPTS=" \
--color=bg+:#363A4F,bg:#24273A,spinner:#F4DBD6,hl:#ED8796 \
--color=fg:#CAD3F5,header:#ED8796,info:#C6A0F6,pointer:#F4DBD6 \
--color=marker:#B7BDF8,fg+:#CAD3F5,prompt:#C6A0F6,hl+:#ED8796 \
--color=selected-bg:#494D64 \
--color=border:#6E738D,label:#CAD3F5 \
--reverse"

# zsh-vi-mode - since the default initialization mode, this plugin will overwrite
# the previous key bindings, this causes the key bindings of other plugins
# (i.e. fzf, zsh-autocomplete, etc.) to fail. 
# The following code is solving this issue.
function my_init() {
  [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
}
zvm_after_init_commands+=(my_init)
