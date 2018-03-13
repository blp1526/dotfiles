#!/usr/bin/env bash

# http://vim-jp.org/docs/build_linux.html
git-clone-to-gopath 'git@github.com:blp1526/vim.git'

# https://github.com/blp1526/tig/blob/master/INSTALL.adoc#build-configuration
# ./autogen.sh
# LDLIBS=-lncursesw CPPFLAGS=-DHAVE_NCURSESW_CURSES_H ./configure
# make
# sudo make install
git-clone-to-gopath 'git@github.com:blp1526/tig.git'

# https://github.com/blp1526/direnv#install
git-clone-to-gopath 'git@github.com:blp1526/direnv.git'

# https://github.com/blp1526/gibo#installation
git-clone-to-gopath 'git@github.com:blp1526/gibo.git'

# https://github.com/peco/peco#building-peco-yourself
git-clone-to-gopath 'https://github.com/peco/peco.git'
