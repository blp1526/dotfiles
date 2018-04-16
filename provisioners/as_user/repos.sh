#!/usr/bin/env bash

# http://vim-jp.org/docs/build_linux.html
git gopath 'git@github.com:blp1526/vim.git'

# https://github.com/blp1526/tig/blob/master/INSTALL.adoc#build-configuration
# ./autogen.sh
# LDLIBS=-lncursesw CPPFLAGS=-DHAVE_NCURSESW_CURSES_H ./configure
# make
# sudo make install
git gopath 'git@github.com:blp1526/tig.git'

# https://github.com/blp1526/direnv#install
git gopath 'git@github.com:blp1526/direnv.git'

# https://github.com/blp1526/gibo#installation
git gopath 'git@github.com:blp1526/gibo.git'

# https://github.com/peco/peco#building-peco-yourself
git gopath 'https://github.com/peco/peco.git'
