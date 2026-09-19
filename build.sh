#!/usr/bin/env bash
# shellcheck disable=SC2086
set -e
scriptPWD=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
. "${scriptPWD}/Build.core.sh"

if [[ ${DIRTY} != "1" ]]; then
    eH "  Cleaning up"
    __make mrproper
    
    eH "  Generating config"
    __make ${DEFCONFIG}

    if [[ -n ${LTO} ]]; then
        configure_lto ${LTO}
    fi
    
    for cmd in "${POST_DEFCONFIG_CMDS[@]}"; do
        eH "  Running pre-make command:"
        execP $cmd
    done
fi

eH "  Starting build"
__make "${M_TARGETS[@]}"

for cmd in "${POST_BUILD_CMDS[@]}"; do
    eH "  Running post-build command:"
    execP $cmd
done

eH "  Build finished"
