export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

export EDITOR='vim'
export IGNOREEOF=256

export GOENV_DISABLE_GOPATH=1
export GOENV_DISABLE_GOROOT=1
export GOPATH=${HOME}

if [ "${PATH_ORIG}" = "" ]; then
  export PATH_ORIG="${PATH}"
fi

export PATH=${HOME}/.anyenv/bin:${HOME}/.cargo/bin:${HOME}/bin:${PATH_ORIG}

if [ -f ~/.bashrc ]; then
  source ~/.bashrc
fi
