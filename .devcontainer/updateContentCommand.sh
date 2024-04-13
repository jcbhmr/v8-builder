#!/usr/bin/env bash
set -e
if [[ $DEBUG == 1 ]]; then set -x; fi

(cd ~
    git clone --depth 1 https://chromium.googlesource.com/chromium/tools/depot_tools.git
    echo 'export PATH="$HOME/depot_tools:$PATH"' >> ~/.bashrc
    echo "Installed depot_tools to $HOME/depot_tools and added to \$PATH in ~/.bashrc"
    echo "See https://commondatastorage.googleapis.com/chrome-infra-docs/flat/depot_tools/docs/html/depot_tools.html"
)
export PATH="$HOME/depot_tools:$PATH"
gclient
echo "Ran 'gclient' to update depot_tools"
