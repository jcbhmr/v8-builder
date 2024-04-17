#!/usr/bin/env bash

generate() (
    v8_sha=$(curl -fsSL https://chromiumdash.appspot.com/fetch_releases?channel=Stable \
        | jq -r '.[0].hashes.v8')
    echo "v8_sha=$v8_sha"
    v8_tag=$(git ls-remote -t https://chromium.googlesource.com/v8/v8.git 2>/dev/null \
        | grep "$v8_sha" \
        | cut -f2 | cut -d/ -f3 | head -n1)
    echo "v8_tag=$v8_tag"
    cd v8
    gclient sync --force --revision v8@"$v8_tag"
)

build() (
    cd v8
    gclient sync

    cd v8
    if [[ $(uname -s) == "Linux" ]]; then
        ./build/install-build-deps.sh
    fi

    gen="x64.release"
    # tools/dev/gm.py "$gen"
    tools/dev/v8gen.py "$gen" -vv -- '
is_component_build = true
use_custom_libcxx = false
'
    ninja -C out.gn/"$gen" v8
    
    cd ../..
    echo done
)

"$@"