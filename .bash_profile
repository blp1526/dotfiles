export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

export EDITOR='vim'
export IGNOREEOF=256

# via https://get.docker.com/rootless
if [ -e ~/bin/docker ]; then
  export XDG_RUNTIME_DIR=/tmp/docker-$(id -u)
  export DOCKER_HOST=unix:///${XDG_RUNTIME_DIR}/docker.sock
fi

export GOENV_DISABLE_GOPATH=1
export GOENV_DISABLE_GOROOT=1
export GOPATH=${HOME}

if [ "${PATH_ORIG}" = "" ]; then
  export PATH_ORIG="${PATH}"
fi

export PATH=${PATH_ORIG}:${HOME}/.anyenv/bin:${HOME}/.cargo/bin:${HOME}/bin

if [ -f ~/.bashrc ]; then
  source ~/.bashrc
fi
