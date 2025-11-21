export ZSH="$HOME/.oh-my-zsh"

# Plugin selection
plugins=(zsh-syntax-highlighting zsh-autosuggestions command-not-found rust)

source $ZSH/oh-my-zsh.sh

# Autosuggestions configuration
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=244'
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# Disable green background in ls and autocomplete
eval "$(dircolors -p | \
    sed 's/ 4[0-9];/ 01;/; s/;4[0-9];/;01;/g; s/;4[0-9] /;01 /' | \
    dircolors /dev/stdin)"

# Add directories to PATH
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# Aliases
## ls
alias ls='ls --color=auto -F -a'
alias cat='batcat'
alias eza='eza -lha --color always --icons'
alias ezas='eza --sort cr -r'
alias l='eza'

## apt
alias au='sudo apt update'
alias afu='sudo apt full-upgrade'
alias ac='sudo apt autoremove && sudo apt autoclean'

## sed
alias sed='sed -E'

## git
alias g='git'
alias gs='g s'
alias gc='g c'
alias gca='g ca'

## gnome
alias set-dock='gsettings set org.gnome.shell.extensions.dash-to-dock dock-position'

# VI mode
bindkey -v
bindkey -M viins 'jk' vi-cmd-mode
bindkey -M vicmd '/' history-incremental-search-backward
bindkey -M viins '^k' history-incremental-search-backward
bindkey -M viins '^j' history-incremental-search-forward

# Enable starship prompt
eval "$(starship init zsh)"
