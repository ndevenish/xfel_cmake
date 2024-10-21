#!/usr/bin/env bash
set -xeuo pipefail

if [[ ! -d cctbx_project ]]; then
    git clone https://github.com/cctbx/cctbx_project
fi
cp -r cctbx_project/xfel/* src/xfel
