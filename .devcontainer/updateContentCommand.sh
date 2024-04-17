#!/usr/bin/env bash
set -e
if [[ $DEBUG == 1 ]]; then set -x; fi

(cd ~
    git clone --depth 1 https://chromium.googlesource.com/chromium/tools/depot_tools.git
    echo 'export PATH="$HOME/depot_tools:$PATH"' >> ~/.bashrc
)
export PATH="$HOME/depot_tools:$PATH"
gclient
echo "Ran 'gclient' to update depot_tools"
