# If you come from bash you might have to change your $PATH
export PATH=$HOME/bin:/usr/local/bin:$HOME/.local/bin:$PATH

# ----------------------------------------------------- 
# FLAGS
# ----------------------------------------------------- 
ENABLE_ERLANG = false
ENABLE_TMUX = false

ERLANG_DEFAULT_VERSION=26

# ----------------------------------------------------- 
# SYSTEM IMPORTS / VARIABLES
# ----------------------------------------------------- 
# source $HOME/.agent-bridge.sh

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"

SCRIPTS="$HOME/.dotfiles/scripts"

# ----------------------------------------------------- 
# ZSH CONFIIG
# ----------------------------------------------------- 

plugins=(
	git
	zsh-autosuggestions
	zsh-syntax-highlighting
	fzf
)
source $ZSH/oh-my-zsh.sh

# ----------------------------------------------------- 
# USER SCRIPT LOADING
# ----------------------------------------------------- 

# If we have created a scripts file $HOME/script then import it to path
if [ -d "$SCRIPTS/scripts" ]; then
    export PATH="$SCRIPTS/scripts:$PATH"
fi

# Use TMUX commands
if [ "$ENABLE_TMUX" = true]; then
    alias ts="tmux-send"
    alias fg="tmux-session main"
    alias bg="tmux-session background"
    alias tmux-source="tmux source-file ~/.config/tmux/tmux.conf"

    if [[ -z $TMUX_HAS_RAN && -z $TMUX ]]; then
        export TMUX_HAS_RAN=true
        tmux-session main
    fi
fi

# Erlang Support
if [ "$ENABLE_ERLANG" = true]; then
    # Function to handle invocation of `erlang_version` allows easy switching between erlang versions
    # Includes rebar3 setup
    # Usage:
    erlvsn(){
        . "$SCRIPTS/scripts/erlang_version" $1
    }
    
    # Start Erlang
    erlvsn $ERLANG_DEFAULT_VERSION
fi

# WSL Support
if [ -n "$WSL_DISTRO_NAME" ]; then
    alias ssh="/mnt/c/Windows/System32/OpenSSH//ssh.exe" # or just ssh.exe
    alias ssh-add="/mnt/c/Windows/System32/OpenSSH//ssh-add.exe" # or just ssh-add.exe
fi

# ----------------------------------------------------- 
# ALIASES
# ----------------------------------------------------- 

alias ohmyzsh="nvim ~/.oh-my-zsh"
alias zshconfig="nvim ~/.zshrc"
alias zshreload="source ~/.zshrc"
alias vim="nvim"

# ----------------------------------------------------- 
# FUNCTIONS
# - To be seperated later
# ----------------------------------------------------- 

# run the stow command for the passed in directory ($2) in location $1
stowit() {
    usr=$1
    app=$0
    # -v verbose
    # -R recursive
    # -t target
    stow -v -R -t ${usr} ${app}
}


# ----------------------------------------------------- 
# MISC
# ----------------------------------------------------- 
