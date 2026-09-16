#!/usr/bin/env bash

set -e
M_OVERRIDE_ARGS=("$@")
scriptPWD=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
. "${scriptPWD}/core_utils.sh"
. "${scriptPWD}/etc_utils.sh"
. "${scriptPWD}/etc_kconfigs.sh"
. "${scriptPWD}/options.sh"
envsetup

if [[ ${NO_CLEANING} != "1" ]]; then
    eee "> Cleaning up"
    __make mrproper
    
    eee "> Generating config"
    __make "${DEFCONFIG}"
    
    if [ -n "${POST_DEFCONFIG_CMDS}" ]; then
        eee "> Running pre-make command(s):"
        set +e -x
        eval "${POST_DEFCONFIG_CMDS}"
        set -e +x
    fi
fi

eee "> Starting build"
__make "${M_TARGETS[@]}"

if [ -n "${POST_BUILD_CMDS}" ]; then
    eee "> Running post-build command(s):"
    set +e -x
    eval "${POST_BUILD_CMDS}"
    set -e +x
fi

eee "> Build finished"
