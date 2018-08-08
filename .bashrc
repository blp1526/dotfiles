# settings for each Linux distribution
if [ -e /etc/fedora-release ]; then
  source /usr/share/bash-completion/bash_completion
  source /usr/share/doc/git-core-doc/contrib/completion/git-completion.bash
  source /usr/share/doc/git-core-doc/contrib/completion/git-prompt.sh
fi

if [ -e /etc/lsb-release ]; then
  source /etc/profile.d/bash_completion.sh
  source /etc/bash_completion.d/git-prompt
fi

if [ -e /etc/arch-release ]; then
  source /usr/share/bash-completion/bash_completion
  source /usr/share/git/completion/git-completion.bash
  source /usr/share/git/git-prompt.sh

  # https://wiki.archlinux.org/index.php/Color_output_in_console#man
  man() {
    LESS_TERMCAP_md=$'\e[01;31m' \
    LESS_TERMCAP_me=$'\e[0m' \
    LESS_TERMCAP_se=$'\e[0m' \
    LESS_TERMCAP_so=$'\e[01;44;33m' \
    LESS_TERMCAP_ue=$'\e[0m' \
    LESS_TERMCAP_us=$'\e[01;32m' \
    command man "${@}"
  }
fi

# functions
c() {
  local previous_dir=$(pwd)
  local selected_dir=$(find -L "${GOPATH}/src" -maxdepth 3 -mindepth 3 -type d | peco)
  # XXX: case SIGINT
  if [ "${selected_dir}" = "" ]; then
    cd ${previous_dir}
  else
    cd ${selected_dir}
  fi
}

jobs_size() {
  local jobs_size=$(jobs | wc -l)
  if [ ${jobs_size} -gt 0 ]; then
    echo "[jobs: ${jobs_size}] "
  else
    echo ""
  fi
}

repo_name_or_short_pwd() {
  if [ ${PWD} = ${HOME} ]; then
    echo "~"
  elif [ -e ${PWD}/.git ]; then
    echo $(awk -F / '{ print $(NF-1)"/"$(NF) }' <<< ${PWD})
  else
    echo $(basename ${PWD})
  fi
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
PS1_DIR=${FG_BLUE}'$(repo_name_or_short_pwd)'
PS1_BRANCH=${FG_RED}'$(__git_ps1)'
PS1_DOLLAR=${FG_NORMAL}'\n\$ '
PS1="${PS1_JOBS_SIZE}${PS1_USER}${PS1_SEPARATOR}${PS1_DIR}${PS1_BRANCH}${PS1_DOLLAR}"

# alias
alias ls='ls --color=auto --group-directories-first'
alias less='less -I --chop-long-lines'
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias dmesg='dmesg --human --color=auto'
alias tree='tree -I ".git|tags|vendor|node_modules|dist|tmp"'
alias info='info --vi-keys'

alias inode='stat -c %i'
alias hex2dec="printf '%d\n'"
alias dec2hex="printf '%x\n'"
alias yyyymmddhhmm="date +%Y%m%d%H%M"

# direnv
if type direnv >/dev/null 2>&1; then
  eval "$(direnv hook bash)"
fi

# npm-completion
if [ -e ~/.npm-completion.sh ]; then
  source ~/.npm-completion.sh
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

# The next line updates PATH for the Google Cloud SDK.
if [ -f "$HOME/.google-cloud-sdk/path.bash.inc" ]; then
  source "$HOME/.google-cloud-sdk/path.bash.inc"
fi

# The next line enables shell command completion for gcloud.
if [ -f "$HOME/.google-cloud-sdk/completion.bash.inc" ]; then
  source "$HOME/.google-cloud-sdk/completion.bash.inc"
fi
