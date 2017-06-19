export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export GOPATH=${HOME}
export PATH=${PATH}:/usr/local/sbin:${HOME}/.nodebrew/current/bin:${HOME}/bin:${HOME}/.bats/bin
export EDITOR='vim'

IGNOREEOF=256
export IGNOREEOF

if [ -e /etc/arch-release ]; then
  export KERNEL_PATH=/usr/lib/modules/$(uname -r)/build/include
fi

if [ -f ~/.bashrc ] ; then
  . ~/.bashrc
fi
