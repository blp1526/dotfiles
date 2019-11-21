.PHONY: all
all: lint

.PHONY: requirements
requirements:
	pip install editorconfig-checker

.PHONY: lint
lint:
	editorconfig-checker
	shellcheck -e SC2002 -e SC2181 ./provisioners/*.sh
