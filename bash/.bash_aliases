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
alias ls='ls --color=auto'
alias cat='pygmentize -g'
