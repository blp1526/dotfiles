export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export GOPATH=${HOME}/.go
export PATH=${PATH}:/usr/local/sbin:${GOPATH}/bin:${HOME}/.nodebrew/current/bin:${HOME}/bin:${HOME}/.bats/bin
export EDITOR='vim'

IGNOREEOF=256
export IGNOREEOF

if [ -f ~/.bashrc ] ; then
  . ~/.bashrc
fi
