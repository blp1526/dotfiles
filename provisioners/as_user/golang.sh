#!/usr/bin/env bash
set -x

go get -u github.com/derekparker/delve/cmd/dlv
go get -u github.com/golang/dep/cmd/dep
go get -u github.com/goreleaser/goreleaser
go get -u github.com/fzipp/gocyclo
go get -u github.com/mattn/mkup

go get -u github.com/alecthomas/gometalinter
gometalinter --install

# https://github.com/nsf/gocode/issues/368
go get -u github.com/nsf/gocode
gocode close
gocode set unimported-packages true
