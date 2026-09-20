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
    local text=$1
    local modal=$2
    local modalcolor
    local abrt
    case ${modal} in
        "warning" | "notice") modalcolor=$_yel;;
        "error") modalcolor=$_red; abrt=1;;
    esac
    if [[ -n ${modal} ]]; then
        modal="${modal}: "
    fi
    echo -e "${modalcolor}${modal}${_white}${text}${_restore}"
    if [[ -n ${abrt} ]]; then
        exit 1
    fi
}
eH() {
    eM "$(ehr)\n$1"
}
getval() {
    eval "echo \$$1"
}
add_M_arg() {
    MAKE_ARGS+=("$@")
}
add_M_var() {
    for v in "$@"; do
        _v=$(getval "$v")
        if [[ -n $_v ]]; then
            add_M_arg "$1=$_v"
        fi
    done
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
use_config() {
    [[ -f "$1" ]] || return 1
    eH "  Using config file:"
    set -a
    # shellcheck disable=SC1090
    . "$1"
    set +a
}
safe_unset() {
    for v in "$@"; do
        _v=$(getval "$v")
        if [[ -z $_v ]]; then
            unset "$v"
        else
            echo "$v=$_v"
        fi
    done
}
execP() {
    eM "\n> $*"
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
    add_M_var LD AR NM OBJCOPY OBJDUMP READELF OBJSIZE STRIP
    safe_unset KBUILD_OUTPUT ARCH LLVM LLVM_IAS \
        CLANG_TRIPLE CROSS_COMPILE CROSS_COMPILE_ARM32 CROSS_COMPILE_COMPAT \
        KBUILD_BUILD_TIMESTAMP KBUILD_BUILD_HOST KBUILD_BUILD_USER KBUILD_BUILD_VERSION
    export MAKEFLAGS
    if [[ -d ${TC_HOME} ]]; then
        export PATH=$TC_HOME:$PATH
    fi
    if [[ ${USE_CCACHE} = "1" ]]; then
        eM "setting KBUILD_BUILD_TIMESTAMP='' to avoid ccache miss" "notice"
        eM "please only USE_CCACHE for local development builds." "notice"
        export KBUILD_BUILD_TIMESTAMP=
        add_M_arg "CC=ccache ${CC}"
    fi
    print_path
    execP "${CC}" -v
}
