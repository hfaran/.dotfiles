#!/usr/bin/env bash

# We source .bashrc first so we can override any OS X-specific stuff later
source ~/.bashrc

# http://stackoverflow.com/a/14970926
# Must `brew install git bash-completion` before-hand
if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
fi

source ~/.osx_bash_aliases

# Important so that we use stuff from `brew` rather than system stuff
export PATH=/usr/local/bin:/usr/local/sbin:$PATH
# Requires `brew install coreutils`
PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
# For homebrew/science/root
. $(brew --prefix root)/bin/thisroot.sh
# GOPATH
eval export GOPATH="~/go"
# brew install z
. `brew --prefix`/etc/profile.d/z.sh

fixwifi () {
    set -x
    # This fixes (i.e., restarts) the WiFi
    ping -c 1 -t 2 8.8.8.8  # ping google
    result=`echo $?`
    if [[ "$result" == "0" ]]
    then
        echo "WiFi is A-Ok."
    else
        echo "WiFi is broke; fixing."
        networksetup -setairportpower en0 off
        sleep 3
        networksetup -setairportpower en0 on
    fi
    set +x
}

cleanbrew () {
    set -x
    mkdir -p "/Users/$USER/Library/Caches/Homebrew/Casks"
    brew cask cleanup
    brew cleanup --force -s
    rm -rf $(brew --cache)
    brew prune
    mkdir -p "/Users/$USER/Library/Caches/Homebrew/Casks"
    set +x
}

function full_acl_access {
    # https://www.thomaskeller.biz/blog/2011/06/04/acls-on-mac-os-x/
    sudo /bin/chmod +a "$1 allow read,write,delete,add_file,add_subdirectory,file_inherit,directory_inherit" $2
}

# https://gorails.com/setup/osx/10.10-yosemite
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# Java things
export JAVA_HOME=$(/usr/libexec/java_home)
export ANDROID_HOME=/usr/local/opt/android-sdk

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"
