#!/usr/bin/env bash

printf 'Cleaning ball-move %s\n' "$PWD"

for file in *.dbg *.prg *.d64 *.sym *.vs ByteDump.txt .source.txt; do
    if [[ -f "$file" ]]; then
        rm -- "$file" && printf 'rm -- %s\n' "$file"
    fi
done
