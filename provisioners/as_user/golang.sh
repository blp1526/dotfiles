#!/usr/bin/env bash
set -x

go get -u golang.org/x/tools/cmd/stringer
go get -u golang.org/x/tools/cmd/golsp
go get -u github.com/golang/dep/cmd/dep

go get -u github.com/alecthomas/gometalinter
gometalinter --install

go get -u github.com/derekparker/delve/cmd/dlv
go get -u github.com/mattn/mkup
go get -u github.com/yusukebe/revealgo/cmd/revealgo
