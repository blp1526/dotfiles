#!/bin/bash -ex

defaults write com.apple.screencapture location ~/Pictures/
killall SystemUIServer
