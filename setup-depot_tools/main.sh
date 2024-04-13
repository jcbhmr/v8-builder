#!/usr/bin/env bash
set -e
if [[ $RUNNER_DEBUG == 1 ]]; then set -x; fi

cd ~
git clone --depth 1 https://chromium.googlesource.com/chromium/tools/depot_tools.git
echo "$HOME/depot_tools" >> "$GITHUB_PATH"
echo "Installed depot_tools to $HOME/depot_tools and added to \$PATH"
echo "See https://commondatastorage.googleapis.com/chrome-infra-docs/flat/depot_tools/docs/html/depot_tools.html"

gclient
echo "Ran 'gclient' to update depot_tools"
