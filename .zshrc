# Created by newuser for 5.8


autoload -U colors && colors
autoload -Uz promptinit && promptinit


HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory


# set up completion
autoload -Uz compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit

# Initialise vimode to insert mode
vimode=1


export ZSH_PLUGIN_DIR=$HOME/.config/zsh/plugins

# Use ctrl-e to edit command in vim
autoload edit-command-line; zle -N edit-command-line

function source_file() {
	if [[ -f "$1" ]]; then
	    source "$1" >> /dev/null 2>> /dev/null
	fi
}

function load_zsh_config() {
    source_file "${HOME}/.config/zsh/$1"
}

function load_zsh_plugin() {
    local plugin_name=$(echo $1 | cut -d "/" -f 2);
    if [[ -d $ZSH_PLUGIN_DIR/$plugin_name ]]; then
        source_file $ZSH_PLUGIN_DIR/$plugin_name/$plugin_name.plugin.zsh || \
        source_file $ZSH_PLUGIN_DIR/$plugin_name/$plugin_name.zsh
    else
        git clone "https://github.com/$1.git" "$ZSH_PLUGIN_DIR/$plugin_name" >> /dev/null \
            && load_zsh_plugin $1
    fi
}

source_file ${HOME}/.zsh_local

load_zsh_config "functions.zsh"
load_zsh_config "alias.zsh"
load_zsh_config "keybind.zsh"

load_zsh_plugin zsh-users/zsh-completions
source_file /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh



if hash starship 2>/dev/null; then 
    eval "$(starship init zsh)"
else
    if [[ ! -d $ZSH_PLUGIN_DIR/spaceship ]]; then 
        git clone "https://github.com/spaceship-prompt/spaceship-prompt.git" "$ZSH_PLUGIN_DIR/spaceship"
    fi
    source "$ZSH_PLUGIN_DIR/spaceship/spaceship.zsh"

fi

if hash zoxide 2> /dev/null; then
    eval "$(zoxide init zsh)"
fi

if [ -d ${HOME}/.config/zsh/conf.d/ ]; then
    for file in ${HOME}/.config/zsh/conf.d/*(N); do
        source $file
    done
fi

if [[ -d ${HOME}/.config/zsh/completions/ ]]; then
    fpath+=${HOME}/.config/zsh/completions/
fi
