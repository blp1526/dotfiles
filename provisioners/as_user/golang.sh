#!/usr/bin/env bash
set -x

curl https://glide.sh/get | sh
go get -u github.com/derekparker/delve/cmd/dlv
go get -u github.com/golang/dep/cmd/dep
go get -u github.com/goreleaser/goreleaser
go get -u github.com/fzipp/gocyclo
go get -u github.com/mattn/mkup

go get -u golang.org/x/tools/cmd/stringer
go get -u github.com/alecthomas/gometalinter
gometalinter --install
