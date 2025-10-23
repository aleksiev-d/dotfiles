export ZSH="$HOME/.oh-my-zsh"
export FZF_DEFAULT_OPTS="--reverse"

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

ZSH_THEME="cypher"

plugins=(
    git
    dotnet
    zsh-autosuggestions
    #zsh-vi-mode
)

source $ZSH/oh-my-zsh.sh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
