#!/usr/bin/env zsh
backup="$(ls -Art "$@" | tail -n 1)"
unzip -d server $backup
