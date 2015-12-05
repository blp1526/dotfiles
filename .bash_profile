export LANG=en_US.UTF-8
export GOPATH=${HOME}/.go
export PATH=${PATH}:${GOPATH}/bin:${HOME}/.nodebrew/current/bin

if [ -f ~/.bashrc ] ; then
  . ~/.bashrc
fi
