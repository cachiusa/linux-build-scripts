# shellcheck disable=SC2034,SC2163
set_colors() {
    if [[ -n ${GITHUB_ACTION} || -t 1 ]]; then
        _restore='\e[0m'
        _red='\e[1;91m'
        _green='\e[1;92m'
        _white='\e[1;97m'
        _yel='\e[1;33m'
    fi
}
ehr() {
    echo "========================================================"
}
eM() {
    local modal=$1
    local text=$2
    local modalcolor
    case ${modal} in
        "warning" | "notice") modalcolor=$_yel;;
        "error") modalcolor=$_red;;
    esac
    if [[ -n ${modal} ]]; then
        modal="${modal}: "
    fi
    echo -e "${modalcolor}${modal}${_white}${text}${_restore}"
}
eH() {
    eM "" "$(ehr)\n$1"
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
    eM "" "\n> $*"
    "$@"
}
envsetup() {
    set_colors
    MAKE_ARGS=()
    MAKEFLAGS="-j$(nproc) ${MAKEFLAGS}"
    if [[ -z ${CC} ]]; then
        if [[ -n ${LLVM} ]]; then
            CC=clang
        else
            CC=${CROSS_COMPILE}gcc
        fi
    else
        add_M_var CC
    fi
    if [[ ${USE_CCACHE} = "1" ]]; then
        eM "notice" "setting KBUILD_BUILD_TIMESTAMP='' to avoid ccache miss"
        eM "notice" "please only USE_CCACHE for local development builds."
        export KBUILD_BUILD_TIMESTAMP=
        add_M_arg "CC=ccache ${CC}"
    fi
    if [[ -d ${TC_HOME} ]]; then
        export PATH=$TC_HOME:$PATH
    fi
    exportP MAKEFLAGS KBUILD_OUTPUT ARCH CROSS_COMPILE CLANG_TRIPLE LLVM LLVM_IAS \
        KBUILD_BUILD_TIMESTAMP KBUILD_BUILD_HOST KBUILD_BUILD_USER KBUILD_BUILD_VERSION
    print_path
    execP "${CC}" -v
}
