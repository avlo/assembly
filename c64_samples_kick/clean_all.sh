#!/usr/bin/env bash

if [[ -f ./clean.sh ]]; then
    bash ./clean.sh
fi

for dir in */; do
    if [[ -f "$dir/clean.sh" ]]; then
        (cd -- "$dir" && bash ./clean.sh)
    fi
done
