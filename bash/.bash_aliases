#!/bin/bash

################
# Requirements #
################

## system packages

# git
# python2.7
# apt-fast

## pip packages

# trash-cli
# pygments

####################


UNAMESTR=$(uname)


##################
# Global Aliases #
##################


# git aliases
alias gs='git status'
alias gd="git diff --color"
# https://www.kernel.org/pub/software/scm/git/docs/git-clean.html
alias clean_this_git_up='sudo git clean -ndfx -e .idea'
alias clean_this_git_up_for_real='sudo git clean -dfx -e .idea'


# Misc program aliases
alias python27="python2.7"

alias catp='pygmentize -g'
if [[ "$UNAMESTR" == "Linux" ]]; then
    alias ls='ls --color=auto'
elif [[ "$UNAMESTR" == "Darwin" ]]; then
    if [[ -z $(brew list | grep coreutils) ]]; then
        echo "Please run `brew install coreutils` to install a good ls"
    else
        alias ls='ls --color=auto'
    fi
fi
alias la='ls -A'
alias ll='la -lhF'

alias h='history'
alias xclipb='xclip -selection clipboard'
alias howdoi='howdoi -c'
alias htop='glances'  # Because I always forget


# Navigational aliases
alias up='cd ..'
alias ..='cd ..'
alias ...='cd ../..'
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."


if [[ "$UNAMESTR" == *CYGWIN* ]]; then

    ##################
    # Cygwin Aliases #
    ##################

    alias subl="/cygdrive/c/Program\ Files/Sublime\ Text\ 3/sublime_text.exe"


elif [[ "$UNAMESTR" == "Linux" ]]; then

    #################
    # Linux Aliases #
    #################

    # Common util aliases
    alias dist-update="sudo apt-fast update; sudo apt-fast dist-upgrade -y"
    alias rm='echo "This is not the command you are looking for. Use trash-put."; false'
    alias tp='trash-put'

    # Add an "alert" alias for long running commands.  Use like so:
    #   sleep 10; alert
    alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

    # open alias for consistency with OS X
    alias open='xdg-open'


fi
