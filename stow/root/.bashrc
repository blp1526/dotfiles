#!/usr/bin/env bash

# export
if [ "${PATH_ORIG}" == "" ]; then
  export PATH_ORIG="${PATH}"
fi
export PATH="${HOME}/bin:${PATH_ORIG}"

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

GPG_TTY="$(tty)"
export GPG_TTY

export EDITOR='nvim'
export IGNOREEOF=256

if [ "$(uname)" == "Darwin" ]; then
  alias ll='gls -l --color=auto --group-directories-first'
  export BASH_SILENCE_DEPRECATION_WARNING=1
  if type brew >/dev/null 2>&1; then
    source "$(brew --prefix)/etc/bash_completion"
    source "$(brew --prefix asdf)/libexec/asdf.sh"
    source "$(brew --prefix asdf)/etc/bash_completion.d/asdf.bash"
  fi
else
  # Ubuntu
  alias ll='ls -l --color=auto --group-directories-first'
  source "/usr/lib/git-core/git-sh-prompt"
  source "${HOME}/.asdf/asdf.sh"
  source "${HOME}/.asdf/completions/asdf.bash"

  # only server or Wayland desktop
  if [ "$XDG_SESSION_TYPE" != "x11" ]; then
    # disable tty lock
    stty stop undef
  fi
fi

# direnv
if type direnv >/dev/null 2>&1; then
  eval "$(direnv hook bash)"
fi

# zoxide
if type zoxide >/dev/null 2>&1; then
  eval "$(zoxide init bash)"
fi

# alias
alias la='ll -a'
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'

# function
jump() {
  local current_dir
  current_dir="$(pwd)"

  local selected_dir
  selected_dir="$(ghq list --full-path | peco)"

  local next_dir
  if [ "${selected_dir}" = "" ]; then
    next_dir="${current_dir}"
  else
    next_dir="${selected_dir}"
  fi

  cd "${next_dir}"
}

# shell variables
SHELL='bash'
HISTSIZE='10000'
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
GIT_PS1_SHOWUNTRACKEDFILES=true

PS1_USER=${FG_GREEN}'\u@\H'
PS1_SEPARATOR=${FG_LIGHT_GRAY}':'
PS1_DIR=${FG_BLUE}'\W'
# shellcheck disable=SC2016
PS1_BRANCH=${FG_RED}'$(__git_ps1)'
PS1_DOLLAR=${FG_NORMAL}'\n\$ '
PS1="${PS1_USER}${PS1_SEPARATOR}${PS1_DIR}${PS1_BRANCH}${PS1_DOLLAR}"
