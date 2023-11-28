# If you come from bash you might have to change your $PATH
export PATH=$HOME/bin:/usr/local/bin:$HOME/.local/bin:$PATH



## Language Imports
# export PATH=$PATH:~/.cargo/bin
# source "$HOME/.cargo/env"


# Erlang
ERLANG_DEFAULT_VERSION=26
# source $HOME/.evm/scripts/evm
# We use a script for this now
# export PATH=/home/jcs/.cache/rebar3/bin:$PATH


## System Imports
source $HOME/.agent-bridge.sh
# [ -d /usr/lib/rustup/bin ] && PATH=$PATH:/usr/lib/rustup/bin

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"


plugins=(
	git
	zsh-autosuggestions
	zsh-syntax-highlighting
	fzf
)
source $ZSH/oh-my-zsh.sh

# If scripts imported from .dotfiles then import
    # cd $HOME/.dotfiles & stow scripts
if [ -d "$HOME/scripts" ]; then
    export PATH="$HOME/scripts:$PATH"
    alias ts="tmux-send"
    alias fg="tmux-session main"
    alias bg="tmux-session background"

    if [[ -z $TMUX_HAS_RAN && -z $TMUX ]]; then
        export TMUX_HAS_RAN=true
        tmux-session main
    fi

    # Function to handle invocation of `erlang_version` allows easy switching between erlang versions
    # Includes rebar3 setup
    # Usage:
    erlvsn(){
        . "$HOME/scripts/erlang_version" $1
    }
    

    # Start Erlang
    erlvsn $ERLANG_DEFAULT_VERSION

fi

# if [ -n "$WSL_DISTRO_NAME" ]; then
#     alias ssh="/mnt/c/Windows/System32/OpenSSH//ssh.exe" # or just ssh.exe
#     alias ssh-add="/mnt/c/Windows/System32/OpenSSH//ssh-add.exe" # or just ssh-add.exe
# fi


alias ohmyzsh="nvim ~/.oh-my-zsh"
alias zshconfig="nvim ~/.zshrc"
alias zshreload="source ~/.zshrc"
alias vim="nvim"
alias tmux-source="tmux source-file ~/.config/tmux/tmux.conf"

####################
# Functions (Move later)

# run the stow command for the passed in directory ($2) in location $1
stowit() {
    usr=$1
    app=$0
    # -v verbose
    # -R recursive
    # -t target
    stow -v -R -t ${usr} ${app}
}


 
#####################


# Node Version Manger Configuration
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# bun completions
[ -s "/home/jcs/.bun/_bun" ] && source "/home/jcs/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
