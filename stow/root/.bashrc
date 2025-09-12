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

alias ll='gls -l --color=auto --group-directories-first'
export BASH_SILENCE_DEPRECATION_WARNING=1
if type brew >/dev/null 2>&1; then
  source "$(brew --prefix)/etc/bash_completion"
  source <(asdf completion bash)
fi

# direnv
if type direnv >/dev/null 2>&1; then
  eval "$(direnv hook bash)"
fi

if type zoxide >/dev/null 2>&1; then
  eval "$(zoxide init bash)"
fi

# alias
alias la='ll -a'
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias lazygit="XDG_CONFIG_HOME=${HOME}/.config lazygit"

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
