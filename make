#!/usr/bin/env bash

# Standalone make wrapper

scriptPWD=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
. "${scriptPWD}/core_utils.sh"
. "${scriptPWD}/etc_utils.sh"
. "${scriptPWD}/etc_kconfigs.sh"
. "${scriptPWD}/options.sh"
envsetup

__make "$@"
