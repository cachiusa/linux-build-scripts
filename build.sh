#!/usr/bin/env bash
set -e
scriptPWD=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
. "${scriptPWD}/Build.core.sh"

if [[ ${DIRTY} != "1" ]]; then
    eee "  Cleaning up"
    __make mrproper
    
    eee "  Generating config"
    __make "${DEFCONFIG}"

    if [[ -n ${LTO} ]]; then
        configure_lto "${LTO}"
    fi
    
    for cmd in "${POST_DEFCONFIG_CMDS[@]}"; do
        eee "  Running pre-make command:"
        # shellcheck disable=SC2086
        execP $cmd
    done
fi

eee "  Starting build"
__make "${M_TARGETS[@]}"

for cmd in "${POST_BUILD_CMDS[@]}"; do
    eee "  Running post-build command:"
    # shellcheck disable=SC2086
    execP $cmd
done

eee "  Build finished"
