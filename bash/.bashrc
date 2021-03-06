#!/bin/bash

# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# For setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=20000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Append history of current shell to historyfile on every command
# THIS DOES NOT RELOAD THE HISTORY OF THIS SHELL; only provides
#   it to new shells that will be opened
export PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
# echo -e "Defining bash_aliases... \c"
if [ -f ~/.bash_aliases ]
then
  .  ~/.bash_aliases
fi
# echo -e "Done. \c"

# Enable bash completion in interactive shells
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Set smiley-face PS1
_smiley="\`if [ \$? = 0 ]; then echo \[\e[33m\]^_^\[\e[0m\]; else echo \[\e[31m\]O_O\[\e[0m\]; fi\`"
_PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[01;34m\] \w \n\$\[\033[00m\] '
PS1="${_smiley}${_PS1}"

# Requires `sudo apt-get install ncurses-term`
export TERM=xterm-256color
# Ruby version manager
# echo -e "rvm setup... \c"
if [ -d ~/.rvm/ ]
then
    export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
    source ~/.rvm/scripts/rvm
fi
# echo -e "Done. \c"

# For pipsi
export PATH=~/.local/bin:$PATH

export EDITOR=vim

# pip install virtualenvwrapper
# echo -e "virtualenvwrapper setup... \c"
export WORKON_HOME=~/.virtualenv_Envs
_VIRTUALENVWRAPPER_SH="/usr/local/bin/virtualenvwrapper.sh"
if [ -f $_VIRTUALENVWRAPPER_SH ]
then
    source $_VIRTUALENVWRAPPER_SH
fi
# echo -e "Done. \c"
# tmuxinator
# echo -e "tmuxinator setup... \c"
# Grab bash completion file if it doesn't exist
_TMUX_COMPLETION_FILE="$HOME/.bin/tmuxinator.bash"
if [ ! -f $_TMUX_COMPLETION_FILE ]
then
    mkdir -p ~/.bin/
    wget https://raw.githubusercontent.com/tmuxinator/tmuxinator/master/completion/tmuxinator.bash -P ${HOME}/.bin/
fi
source $_TMUX_COMPLETION_FILE
# echo -e "Done."

# tmux-plugins
# echo -e "Install tmux-plugins if necessary... \c"
if [ ! -d ~/.tmux/plugins/tpm ]
then
    echo "Installing tmux-plugins..."
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi
# echo -e "Done. \c"

# pip/brew install thefuck
# echo -e "Defining tf aliases... \c"
if [ $(which thefuck) ]
then
   eval "$(thefuck --alias pls)"
   eval "$(thefuck --alias fuck)"
fi
# echo -e "Done. \c"

if [ $(uname) == "Linux" ]
then
    # linuxbrew
    _LINUXBREW_PATH="$HOME/.linuxbrew/bin"
    if [ -d $_LINUXBREW_PATH ]
    then
        export PATH="$HOME/.linuxbrew/bin:$PATH"
        export MANPATH="$HOME/.linuxbrew/share/man:$MANPATH"
        export INFOPATH="$HOME/.linuxbrew/share/info:$INFOPATH"

        if [ -f "$_LINUXBREW_PATH/virtualenvwrapper.sh" ]
        then
            source "$_LINUXBREW_PATH/virtualenvwrapper.sh"
        fi
    fi

    # Install z if it's not installed
    if [ ! -f ~/z.sh ]
    then
        echo "Installing z since I didn't find it in your home directory..."
        wget https://raw.githubusercontent.com/rupa/z/master/z.sh -O ~/z.sh
    fi
    # Source z
    . ~/z.sh
fi
