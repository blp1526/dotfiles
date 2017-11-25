#!/usr/bin/env bash
set -x

go get -u github.com/derekparker/delve/cmd/dlv
go get -u github.com/golang/dep/cmd/dep
go get -u github.com/goreleaser/goreleaser
# https://github.com/nsf/gocode/issues/368
go get -u github.com/nsf/gocode
gocode close
gocode set unimported-packages true
