# export
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

export EDITOR='vim'
export IGNOREEOF=256

export DOCKER_HOST="unix:///${XDG_RUNTIME_DIR}/docker.sock"

export GOENV_DISABLE_GOPATH=1
export GOENV_DISABLE_GOROOT=1
export GOPATH=${HOME}

if [ "${PATH_ORIG}" = "" ]; then
  export PATH_ORIG="${PATH}"
fi

export PATH=${HOME}/.anyenv/bin:${HOME}/.cargo/bin:${HOME}/bin:${PATH_ORIG}

# functions
docker-mode() {
  if [ "${1}" = "toggle" ]; then
    if [ "${DOCKER_HOST}" = "" ]; then
      # via https://get.docker.com/rootless
      export DOCKER_HOST="unix:///${XDG_RUNTIME_DIR}/docker.sock"
    else
      unset DOCKER_HOST
    fi
  fi

  if [ "${DOCKER_HOST}" = "" ]; then
    echo "root"
  else
    echo "rootless"
  fi
}

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
  local selected_dir=$(
    find -L "${HOME}/src" -mindepth 3 -maxdepth 4 -type d | \
    grep "\.git$" | sed s/\\/\.git$// | peco
  )
  # XXX: case SIGINT
  if [ "${selected_dir}" = "" ]; then
    cd ${previous_dir}
  else
    cd ${selected_dir}
  fi
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
if [[ -e /usr/lib/git-core/git-sh-prompt ]]; then
  source /usr/lib/git-core/git-sh-prompt
fi
PS1_BRANCH=${FG_RED}'$(__git_ps1)'
PS1_DOLLAR=${FG_NORMAL}'\n\$ '
PS1="${PS1_JOBS_SIZE}${PS1_USER}${PS1_SEPARATOR}${PS1_DIR}${PS1_BRANCH}${PS1_DOLLAR}"

# alias
alias ls='ls --color=auto --group-directories-first --time-style=full-iso'
alias less='less -I --chop-long-lines'
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias dmesg='dmesg --human --ctime --color=auto'
alias tree='tree -I ".git|tags|vendor|node_modules|dist|tmp"'
alias info='info --vi-keys'
alias strace='strace -Ttt -ff -s 1500000'
alias figlet='figlet -k -w 80'
alias lsblk='lsblk --paths'
alias curl='curl --verbose'
alias cal='cal -3'
alias rsync='rsync --archive --update --append-verify --checksum'
alias date='date --iso-8601=ns'
alias readlink='readlink -f'
alias journalctl='journalctl --no-hostname --output short-precise'

alias inode='stat -c %i'
alias hex2dec="printf '%d\n'"
alias dec2hex="printf '%x\n'"
alias udevinfo='udevadm info --query property --name'
alias yyyymmddhhmm="\date +%Y%m%d%H%M"
# via https://github.com/mpolden/echoip
alias myip="\curl --silent https://ifconfig.co/json | jq ."
alias fingerprint="ssh-keygen -E md5 -lf"
alias find-broken-symlinks="find . -xtype l"
alias docker-stats='docker stats --format "table {{.Name}}\t{{.CPUPerc}}\t{{.MemUsage}}"'

# anyenv
if type anyenv >/dev/null 2>&1; then
  eval "$(anyenv init -)"
fi

# direnv
if type direnv >/dev/null 2>&1; then
  eval "$(direnv hook bash)"
fi

# bash-it
if [ -e "${HOME}/src/github.com/Bash-it/bash-it" ]; then
  source "${HOME}/src/github.com/Bash-it/bash-it/completion/available/tmux.completion.bash"
  source "${HOME}/src/github.com/Bash-it/bash-it/completion/available/virsh.completion.bash"
fi

# only server or Wayland desktop
if [ "$XDG_SESSION_TYPE" != "x11" ]; then
  # disable tty lock
  stty stop undef
fi

# only server
if [ "$DISPLAY" = "" ]; then
  # ssh-agent
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
