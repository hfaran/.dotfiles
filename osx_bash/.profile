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
. $(brew --prefix root)/libexec/thisroot.sh
# GOPATH
eval export GOPATH="~/go"
# brew install z
. `brew --prefix`/etc/profile.d/z.sh
# brew install autojump
[[ -s $(brew --prefix)/etc/profile.d/autojump.sh ]] && . $(brew --prefix)/etc/profile.d/autojump.sh
