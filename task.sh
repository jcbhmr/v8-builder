#!/usr/bin/env bash
# Inspired by https://github.com/adriancooney/Taskfile
set -e
if [[ -n $DEBUG ]]; then set -x; fi

generate() (
    # https://v8.dev/docs/version-numbers#which-v8-version-should-i-use%3F
    v8_sha=$(curl -fsSL https://chromiumdash.appspot.com/fetch_releases?channel=Stable \
        | jq -r '.[0].hashes.v8')
    git -C v8 fetch origin "$v8_sha"
    git -C v8 checkout "$v8_sha"
)

setup() (
    cd v8
    gclient sync
    if [[ $(uname -s) == "Linux" ]]; then
        ./build/install-build-deps.sh
    fi
)

build() (
    cd v8
    gclient sync
    tools/dev/gm.py x64.release
)

$@
