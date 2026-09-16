#!/usr/bin/env bash
set -e
scriptPWD=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
. "${scriptPWD}/Build.core.sh"

if [[ ${NO_CLEANING} != "1" ]]; then
    eee "> Cleaning up"
    __make mrproper
    
    eee "> Generating config"
    __make "${DEFCONFIG}"

    if [[ -n ${LTO} ]]; then
        configure_lto "${LTO}"
    fi
    
    for cmd in "${POST_DEFCONFIG_CMDS[@]}"; do
        eee "> Running pre-make command:"
        set +e -x
        eval "$cmd"
        set -e +x
    done
fi

eee "> Starting build"
__make "${M_TARGETS[@]}"

for cmd in "${POST_BUILD_CMDS[@]}"; do
    eee "> Running post-build command:"
    set +e -x
    eval "$cmd"
    set -e +x
done

eee "> Build finished"
