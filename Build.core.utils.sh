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
    M_ARGS+=("$@")
}
add_M_var() {
    # shellcheck disable=SC2086
    _v=$(getval "$1")
    [[ -n ${_v} ]] && M_ARGS+=("$1=$_v")
}
print_path() {
    echo "PATH="
    IFS=':' read -ra __PATH <<< "$PATH"
    for p in "${__PATH[@]}"; do
        echo "     $p"
    done
}
__make() {
    # The make wrapper
    exec2 make "${M_ARGS[@]}" "${M_OVERRIDE_ARGS[@]}" "$@"
}
configure() {
    exec2 ./scripts/config --file "${KBUILD_OUTPUT}/.config" "$@"
    __make olddefconfig
}
commit_time() {
    export TZ=UTC
    export LC_ALL=C
    SOURCE_DATE_EPOCH=$(git log -1 --pretty=%ct)
    date -d @"$SOURCE_DATE_EPOCH"
}
export_and_print() {
    for v in "$@"; do
        export "$v"
        echo "$v=$(getval "$v")"
    done
}
exec2() {
    ee "\n> $*"
    "$@"
}
envsetup() {
    MAKEFLAGS="-j$(nproc) ${MAKEFLAGS}"
    M_ARGS=()
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
    export_and_print MAKEFLAGS KBUILD_OUTPUT ARCH CROSS_COMPILE CLANG_TRIPLE \
        KBUILD_BUILD_TIMESTAMP KBUILD_BUILD_HOST KBUILD_BUILD_USER KBUILD_BUILD_VERSION
    print_path
    # set_colors
    exec2 "${CC}" -v
}
