#!/usr/bin/env bash

# Standalone make wrapper

scriptPWD=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
. "${scriptPWD}/Build.core.sh"

__make "$@"
