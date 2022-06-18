.PHONY: all
all: check

.PHONY: check
check:
	shellcheck .bashrc
	shellcheck *.sh
