# If you come from bash you might have to change your $PATH
export PATH=$HOME/bin:/usr/local/bin:$HOME/.local/bin:$PATH
# export PATH=$PATH:~/.cargo/bin
# source "$HOME/.cargo/env"
source $HOME/.agent-bridge.sh
# [ -d /usr/lib/rustup/bin ] && PATH=$PATH:/usr/lib/rustup/bin

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

plugins=(
	git
	zsh-autosuggestions
	zsh-syntax-highlighting
	fzf
)
source $ZSH/oh-my-zsh.sh


if [ -n "$WSL_DISTRO_NAME" ]; then
    alias ssh="/mnt/c/Windows/System32/OpenSSH//ssh.exe" # or just ssh.exe
    alias ssh-add="/mnt/c/Windows/System32/OpenSSH//ssh-add.exe" # or just ssh-add.exe
fi


alias ohmyzsh="nvim ~/.oh-my-zsh"
alias zshconfig="nvim ~/.zshrc"
alias zshreload="source ~/.zshrc"
alias vim="nvim"
#alias code="vscodium"
alias tmux-source="tmux source-file ~/.config/tmux/tmux.conf"

####################
# Functions (Move later)

# run the stow command for the passed in directory ($2) in location $1
stowit() {
    usr=$1
    app=$2
    # -v verbose
    # -R recursive
    # -t target
    stow -v -R -t ${usr} ${app}
}


#####################

# ASDF Code Toolchain Version Manager
# . /opt/asdf-vm/asdf.sh


# Node Version Manger Configuration
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
