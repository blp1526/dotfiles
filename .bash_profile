export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export GOPATH=${HOME}
export PATH=${PATH}:/usr/local/sbin:${HOME}/.nodebrew/current/bin:${HOME}/bin:${HOME}/.bats/bin:${HOME}/.cargo/bin
export EDITOR='vim'
export IGNOREEOF=256
# http://libguestfs.org/guestfs.3.html#force_tcg via https://bugzilla.redhat.com/show_bug.cgi?id=1648403
export LIBGUESTFS_BACKEND_SETTINGS=force_tcg

if [ -f ~/.bashrc ]; then
  source ~/.bashrc
fi

if [ -f ~/.phpbrew/bashrc ]; then
  source ~/.phpbrew/bashrc
fi
