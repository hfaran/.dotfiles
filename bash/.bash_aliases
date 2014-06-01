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


# git aliases
alias gs='git status'
alias gd="git diff --color"


# Misc program aliases
alias python27="python2.7"


# Common util aliases
alias dist-update="sudo apt-fast update; sudo apt-fast dist-upgrade -y"

alias rm='echo "This is not the command you are looking for. Use trash-put."; false'
alias tp='trash-put'

alias cat='pygmentize -g'
alias ls='ls -A --color=auto'
alias ll='ls -lhF'

alias h='history'


# Navigational aliases
alias up='cd ..'
alias ..='cd ..'
alias ...='cd ../..'
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."
