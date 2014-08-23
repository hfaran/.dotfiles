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


# Misc program aliases
alias python27="python2.7"

alias cat='pygmentize -g'
alias ls='ls --color=auto'
alias la='ls -A'
alias ll='la -lhF'

alias h='history'
alias xclipb='xclip -selection clipboard'
alias howdoi='howdoi -c'


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


fi
