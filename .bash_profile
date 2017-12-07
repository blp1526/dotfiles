export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export GOPATH=${HOME}
export PATH=${PATH}:/usr/local/sbin:${HOME}/.nodebrew/current/bin:${HOME}/bin:${HOME}/.bats/bin
export EDITOR='vim'
export IGNOREEOF=256

if [ -f ~/.bashrc ]; then
  source ~/.bashrc
fi

if [ -f ~/.phpbrew/bashrc ]; then
  source ~/.phpbrew/bashrc
fi
