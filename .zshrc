# creates a python venv
mkvenv() {
    python -m venv venv 
    source "./venv/bin/activate"
}

# open jupyter notebook
jupyter() {
  if [[ $CONDA_DEFAULT_ENV == "jupyter" ]]; then
    /Users/markuspirke/Software/miniforge3/envs/jupyter/bin/jupyter-notebook
  fi
}

# prompt configuration with ohmyposh
eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/zen.toml)"



export PATH="$PATH:/usr/local/texlive/2024/bin/universal-darwin"
export PATH="$PATH:/Users/markuspirke/.config/emacs/bin"

alias juliap="julia --project=."
alias juliapn="julia --project=. --startup-file=no"
alias julian="julia --startup-file=no"

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi
####

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/markuspirke/Software/miniforge3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/markuspirke/Software/miniforge3/etc/profile.d/conda.sh" ]; then
        . "/Users/markuspirke/Software/miniforge3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/markuspirke/Software/miniforge3/bin:$PATH"
    fi
fi
unset __conda_setup

if [ -f "/Users/markuspirke/Software/miniforge3/etc/profile.d/mamba.sh" ]; then
    . "/Users/markuspirke/Software/miniforge3/etc/profile.d/mamba.sh"
fi
# <<< conda initialize <<<

# add go to PATH
export PATH="/usr/local/go/bin:$PATH"
export PATH="/Users/markuspirke/go/bin:$PATH"



source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk

# ZSH PLUGINS
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# COMPLETIONS
autoload -Uz compinit && compinit

# Keybinding
bindkey -e
bindkey '^p' history-search-backward #ensures that the history is searched based on what i started typing
bindkey '^n' history-search-forward
# History
HISTSIZE=500000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
#zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup



# ALIASES
alias ls='ls --color'
alias ll='ls -la --color'

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."
alias history="history -n 0"
alias pass-ecap='PASSWORD_STORE_DIR=~/.password-store-ecap pass'
alias vim="nvim"

#alias vim='vim -u $HOME/.config/vim/vimrc'

# Shell integrations
source <(fzf --zsh)

# Created by `pipx` on 2025-04-25 16:08:04
export PATH="$PATH:/Users/markuspirke/.local/bin"

# >>> juliaup initialize >>>

# !! Contents within this block are managed by juliaup !!

path=('/Users/markuspirke/.juliaup/bin' $path)
export PATH
# Tab completion for juliaup and julia channel selection
[ -f "/Users/markuspirke/.julia/juliaup/completions/zsh.zsh" ] && source "/Users/markuspirke/.julia/juliaup/completions/zsh.zsh"

# <<< juliaup initialize <<<
