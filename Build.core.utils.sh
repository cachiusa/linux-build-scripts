# shellcheck disable=SC2163
set_colors() {
    if [[ -n ${GITHUB_ACTION} || -t 1 ]]; then
        _restore='\e[0m'
        _green='\e[1;32m'
        _white='\e[1;37m'
    fi
}
ehr() {
    echo "========================================================"
}
ee() {
    echo -e "$1"
}
eee() {
    ee "$(ehr)\n${_green}$1${_restore}"
}
getval() {
    eval "echo \$$1"
}
add_M_arg() {
    MAKE_ARGS+=("$@")
}
add_M_var() {
    _v=$(getval "$1")
    if [[ -n $_v ]]; then
        add_M_arg "$1=$_v"
    fi
}
print_path() {
    echo "PATH="
    IFS=':' read -ra __PATH <<< "$PATH"
    for _p in "${__PATH[@]}"; do
        echo "     $_p"
    done
}
__make() {
    # The make wrapper
    execP make "${MAKE_ARGS[@]}" "${MAKE_OVERRIDE_ARGS[@]}" "$@"
}
configure() {
    execP ./scripts/config --file "${KBUILD_OUTPUT}/.config" "$@"
    __make olddefconfig
}
commit_time() {
    export TZ=UTC
    export LC_ALL=C
    SOURCE_DATE_EPOCH=$(git log -1 --pretty=%ct)
    date -d @"$SOURCE_DATE_EPOCH"
}
exportP() {
    for v in "$@"; do
        _v=$(getval "$v")
        if [[ -n $_v ]]; then
            export "$v"
        fi
        echo "$v=$_v"
    done
}
execP() {
    ee "\n> $*"
    "$@"
}
envsetup() {
    MAKE_ARGS=()
    MAKEFLAGS="-j$(nproc) ${MAKEFLAGS}"
    add_M_var LLVM
    add_M_var LLVM_IAS
    add_M_var CC
    if [[ -z ${CC} ]]; then
        if [[ -n ${LLVM} ]]; then
            CC=clang
        else
            CC=${CROSS_COMPILE}gcc
        fi
    fi
    if [[ ${USE_CCACHE} = "1" ]]; then
        add_M_arg "CC=ccache ${CC}"
    fi
    if [[ -d ${TC_HOME} ]]; then
        export PATH=$TC_HOME:$PATH
    fi
    exportP MAKEFLAGS KBUILD_OUTPUT ARCH CROSS_COMPILE CLANG_TRIPLE \
        KBUILD_BUILD_TIMESTAMP KBUILD_BUILD_HOST KBUILD_BUILD_USER KBUILD_BUILD_VERSION
    print_path
    # set_colors
    execP "${CC}" -v
}
