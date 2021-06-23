if [ "$(uname)" == "Darwin" ]; then
  alias ll='gls -l --color=auto --group-directories-first'
  export BASH_SILENCE_DEPRECATION_WARNING=1
  if type brew >/dev/null 2>&1; then
    if type kubectl >/dev/null 2>&1; then
      if ! [ -f "$(brew --prefix)/etc/bash_completion.d/kubectl" ]; then
        kubectl completion bash > "$(brew --prefix)/etc/bash_completion.d/kubectl"
      fi
    fi
    source "$(brew --prefix)/etc/bash_completion"
  fi
else
  # Ubuntu
  alias ll='ls -l --color=auto --group-directories-first'
  source "/usr/lib/git-core/git-sh-prompt"
fi

# export
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

export EDITOR='vim'
export IGNOREEOF=256

export GOENV_DISABLE_GOPATH=1
export GOENV_DISABLE_GOROOT=1
export GOPATH=${HOME}

if [ "${PATH_ORIG}" == "" ]; then
  export PATH_ORIG="${PATH}"
fi

export PATH=${HOME}/bin:${PATH_ORIG}

# functions
dummy-img() {
  local path="${1}"
  local count="${2}"
  local flag="${3}"
  if [ "${flag}" != "--sparse" ]; then
    dd if=/dev/zero of="${path}" bs=1024k count="${count}"
  else
    dd if=/dev/zero of="${path}" bs=1024k count=0 seek="${count}"
  fi
}

c() {
  local previous_dir=$(pwd)
  local selected_dir=$(ghq list --full-path | peco)
  # XXX: case SIGINT
  if [ "${selected_dir}" = "" ]; then
    cd ${previous_dir}
  else
    cd ${selected_dir}
  fi
}

top() {
  echo "x :Column-Highlight, z :Color/Monochrome, < :Move-Sort-Field-Left, > :Move-Sort-Field-Right"
  read
  $(which top)
}

jobs_size() {
  local jobs_size=$(jobs | wc -l)
  if [ "${jobs_size}" -gt 0 ]; then
    echo "[jobs: ${jobs_size}] "
  else
    echo ""
  fi
}

unix2date() {
  date -d "@${1}"
}

mount-vmhgfs() {
  sudo mount -t fuse.vmhgfs-fuse .host:/ /mnt/hgfs -o allow_other
}

# shell variables
SHELL='bash'
HISTSIZE='1000'
HISTTIMEFORMAT='%Y-%m-%dT%T%z '
HISTIGNORE='history:clear:pwd:ls'

FG_NORMAL='\e[m'
FG_BLACK='\e[30m'
FG_RED='\e[31m'
FG_GREEN='\e[32m'
FG_YELLOW='\e[33m'
FG_BLUE='\e[34m'
FG_MAGENTA='\e[35m'
FG_CYAN='\e[36m'
FG_LIGHT_GRAY='\e[37m'

GIT_PS1_SHOWDIRTYSTATE=true
PS1_JOBS_SIZE=${FG_YELLOW}'$(jobs_size)'
PS1_USER=${FG_GREEN}'\u@\H'
PS1_SEPARATOR=${FG_LIGHT_GRAY}':'
PS1_DIR=${FG_BLUE}'\w'
PS1_BRANCH=${FG_RED}'$(__git_ps1)'
PS1_DOLLAR=${FG_NORMAL}'\n\$ '
PS1="${PS1_JOBS_SIZE}${PS1_USER}${PS1_SEPARATOR}${PS1_DIR}${PS1_BRANCH}${PS1_DOLLAR}"

# alias
alias la='ll -a'
alias dotfiles-cp='cp -aiv'
alias dotfiles-less='less -I --chop-long-lines'
alias dotfiles-grep='grep --color=auto'
alias dotfiles-egrep='egrep --color=auto'
alias dotfiles-dmesg='dmesg --human --ctime --color=auto'
alias dotfiles-tree='tree -I ".git|tags|vendor|node_modules|dist|tmp"'
alias dotfiles-info='info --vi-keys'
alias dotfiles-strace='strace -Ttt -ff -s 1500000'
alias dotfiles-figlet='figlet -k -w 80'
alias dotfiles-lsblk='lsblk --paths'
alias dotfiles-cal='cal -3'
alias dotfiles-rsync='rsync --archive --update --append-verify --checksum'
alias dotfiles-date='date --iso-8601=ns'
alias dotfiles-readlink='readlink -f'
alias dotfiles-journalctl='journalctl --no-hostname --output short-precise'

alias dotfiles-inode='stat -c %i'
alias dotfiles-hex2dec="printf '%d\n'"
alias dotfiles-dec2hex="printf '%x\n'"
alias dotfiles-udevinfo='udevadm info --query property --name'
alias dotfiles-yyyymmddhhmm="\date +%Y%m%d%H%M"
alias dotfiles-myip="\curl --silent https://ifconfig.co/json | jq ."
alias dotfiles-fingerprint="ssh-keygen -E md5 -lf"
alias dotfiles-find-broken-symlinks="find . -xtype l"
alias dotfiles-docker-stats='docker stats --format "table {{.Name}}\t{{.CPUPerc}}\t{{.MemUsage}}"'
alias dotfiles-base58='ruby -r active_support/all -e "puts SecureRandom.base58(24)"'
alias dotfiles-dns-servers='systemd-resolve --status'

if [ -e "${HOME}/.asdf" ]; then
  source "${HOME}/.asdf/asdf.sh"
  source "${HOME}/.asdf/completions/asdf.bash"
fi

# direnv
if type direnv >/dev/null 2>&1; then
  eval "$(direnv hook bash)"
fi

# bash-it
if [ -e "${HOME}/src/github.com/Bash-it/bash-it" ]; then
  source "${HOME}/src/github.com/Bash-it/bash-it/completion/available/tmux.completion.bash"
  source "${HOME}/src/github.com/Bash-it/bash-it/completion/available/vagrant.completion.bash"
fi

# only server or Wayland desktop
if [ "$XDG_SESSION_TYPE" != "x11" ]; then
  # disable tty lock
  stty stop undef
fi

# only server
if [ "$DISPLAY" = "" ]; then
  # ssh-agent for tmux
  agent="${HOME}/.ssh/agent"
  if [ -S "${SSH_AUTH_SOCK}" ]; then
    case ${SSH_AUTH_SOCK} in
    /tmp/*/agent.[0-9]*)
      ln -snf "${SSH_AUTH_SOCK}" ${agent} && export SSH_AUTH_SOCK=${agent}
    esac
  elif [ -S ${agent} ]; then
    export SSH_AUTH_SOCK=${agent}
  else
    echo "### no ssh-agent ###"
    echo 'eval `ssh-agent`'
    eval `ssh-agent`
    echo 'ssh-add'
    ssh-add
  fi
fi
