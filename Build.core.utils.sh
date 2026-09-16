set_colors() {
    if [[ -n ${GITHUB_ACTION} || -t 1 ]]; then
        _restore='\e[0m'
        _green='\e[1;32m'
        _white='\e[1;37m'
    fi
}
echohr() {
    echo "========================================================"
}
ee() {
    echo -e "$1"
}
eee() {
    ee "$(echohr)\n${_green}$1${_restore}"
}
add_arg() {
    M_ARGS+=("$@")
}
print_path() {
    eee "PATH="
    IFS=':' read -ra echopaths <<< "$PATH"
    for lst in "${echopaths[@]}"; do
        echo "  $lst"
    done
}
__make() {
    # The make wrapper
    set -x
    make "${M_ARGS[@]}" "${M_OVERRIDE_ARGS[@]}" "$@"
    set +x
}
configure() {
    set -x
    ./scripts/config --file "${OUT_DIR}/.config" "$@"
    set +x
    __make olddefconfig
}
commit_time() {
    export TZ=UTC
    export LC_ALL=C
    SOURCE_DATE_EPOCH=$(git log -1 --pretty=%ct)
    date -d @"$SOURCE_DATE_EPOCH"
}
envsetup() {
    M_ARGS=("-j${JOBS}")
    if [[ -n ${OUT_DIR} ]]; then
        add_arg "O=${OUT_DIR}"
    fi
    if [[ -n ${LLVM} ]]; then
        add_arg "LLVM=1"
        if [[ -n ${LLVM_IAS} ]]; then
            add_arg "LLVM_IAS=1"
        fi
    fi
    if [[ -n ${CLANG_TRIPLE} ]]; then
        add_arg "CLANG_TRIPLE=${CLANG_TRIPLE}"
    fi
    if [[ -n ${CC} ]]; then
        add_arg "CC=${CC}"
    else
        if [[ -n ${LLVM} ]]; then
            CC=clang
        else
            CC=${CROSS_COMPILE}gcc
        fi
    fi
    if [[ ${USE_CCACHE} = "1" ]]; then
        add_arg "CC=ccache ${CC}"
    fi
    export ARCH
    export CROSS_COMPILE
    export KBUILD_BUILD_TIMESTAMP KBUILD_BUILD_HOST KBUILD_BUILD_USER KBUILD_BUILD_VERSION
    export PATH=$TC_HOME:$PATH
    set_colors
    print_path
}
