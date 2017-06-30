# ssh-agent settings
agent="$HOME/.ssh/agent"
if [ -S "$SSH_AUTH_SOCK" ]; then
  case $SSH_AUTH_SOCK in
  /tmp/*/agent.[0-9]*)
    ln -snf "$SSH_AUTH_SOCK" $agent && export SSH_AUTH_SOCK=$agent
  esac
elif [ -S $agent ]; then
  export SSH_AUTH_SOCK=$agent
else
  echo "### no ssh-agent ###"
  echo 'eval `ssh-agent`'
  eval `ssh-agent`
  echo 'ssh-add'
  ssh-add
fi

# git completion & prompt
if [ -e /etc/fedora-release ]; then
  . /usr/share/bash-completion/bash_completion
  . /usr/share/doc/git-core-doc/contrib/completion/git-completion.bash
  . /usr/share/doc/git-core-doc/contrib/completion/git-prompt.sh
fi

if [ -e /etc/lsb-release ]; then
  . /etc/profile.d/bash_completion.sh
  . /etc/bash_completion.d/git-prompt
fi

if [ -e /etc/arch-release ]; then
  . /usr/share/bash-completion/bash_completion
  . /usr/share/git/completion/git-completion.bash
  . /usr/share/git/git-prompt.sh

  ## https://wiki.archlinux.org/index.php/Color_output_in_console#man
  man() {
      LESS_TERMCAP_md=$'\e[01;31m' \
      LESS_TERMCAP_me=$'\e[0m' \
      LESS_TERMCAP_se=$'\e[0m' \
      LESS_TERMCAP_so=$'\e[01;44;33m' \
      LESS_TERMCAP_ue=$'\e[0m' \
      LESS_TERMCAP_us=$'\e[01;32m' \
      command man "$@"
  }
fi

# shell variables
SHELL='bash'
HISTSIZE='1000'
HISTTIMEFORMAT='%Y-%m-%dT%T%z '
HISTIGNORE='history:clear:pwd:ls'

GIT_PS1_SHOWDIRTYSTATE=true
PS1_JOBS_SIZE='\[\033[33m\]$(jobs_size)'
PS1_USER='\[\033[32m\]\u'
PS1_SEPARATOR='\[\033[37m\]:'
PS1_DIR='\[\033[34m\]$(repo_name_or_short_pwd)'
PS1_BRANCH='\[\033[31m\]$(__git_ps1)\[\033[00m\]'
PS1_DOLLAR='\n\$ '
PS1="${PS1_JOBS_SIZE}${PS1_USER}${PS1_SEPARATOR}${PS1_DIR}${PS1_BRANCH}${PS1_DOLLAR}"

# disable tty lock
stty stop undef

c() {
  local previous_dir=$(pwd)
  local selected_dir=$(ghq list --full-path | peco)
  # NOTE: case SIGINT
  if [ "${selected_dir}" = "" ]; then
    cd ${previous_dir}
  else
    cd ${selected_dir}
  fi
}

jobs_size() {
  local jobs_size=$(jobs | wc -l)
  if [ $jobs_size -gt 0 ]; then
    echo "[jobs: $jobs_size] "
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

alias ls='ls --color=auto'
alias egrep='egrep --color=auto'
alias grep='grep --color=auto'
alias tree='tree -I ".git|tags|vendor|node_modules"'
alias inode='stat -c %i'
alias dmesg='dmesg --human --color=auto'

if type direnv >/dev/null 2>&1; then
  eval "$(direnv hook bash)"
fi

source ~/.npm-completion.sh
