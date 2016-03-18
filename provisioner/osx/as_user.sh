#!/bin/bash
set -x

# Install manually below list not by homebrew cask
# Google Chrome
# Firefox
# Google Japanese Input
# iTerm2
# VirtualBox
# VMware
# Vagrant
# Alfred 2
# Atom
# Java
# JMeter
# OWASP ZAP
# Dash
# Evernote
# Skitch
# LICEcap
# Karabiner
# Shiftit
# Slack
# PopHub
# The Unarchiver
# WireShark
# Kindle
# Security Soft

if ! type brew >/dev/null 2>&1; then
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew_names=(
  git
  hub
  gibo
  tig
  'vim --with-lua'
  wget
  tree
  readline
  openssl
  nmap
  ctags
  bash-completion
  tmux
  mobile-shell
  direnv
  the_silver_searcher
  go
  rbenv
  ruby-build
  plenv
  perl-build
  reattach-to-user-namespace
  gawk
  gnu-sed
  parallel
  mysql
  sqlite
  pyenv
)

for brew_name in "${brew_names[@]}"; do
  brew install ${brew_name}
done

if type atom >/dev/null 2>&1; then
expected_apm_packages=$(cat << EOS
atom-beautify
atom-ctags
atom-fuzzy-grep
autoclose-html
autocomplete-paths
color-picker
ex-mode
file-icons
language-babel
linter
linter-jshint
linter-rubocop
minimap
minimap-autohide
project-manager
rails-open-rspec
railscast-theme
script
terminal-plus
vim-mode
vim-mode-visual-block
EOS
)
  current_apm_packages=$(apm list --installed --bare | awk -F @ '$NF != "" { print $1; }')
  apm_packages=$(
    diff -u <(echo "${current_apm_packages}") <(echo "${expected_apm_packages}") |
    awk '$1 != "+++" && $1 ~ /^\+/ { sub(/^\+{1}/, "", $1); print $1; }'
  )
  if [ "${apm_packages}" != "" ]; then
    for apm_package in "${apm_packages}"; do
      apm install ${apm_package}
    done
  fi
fi
