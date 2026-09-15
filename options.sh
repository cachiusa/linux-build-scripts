# The number of jobs (commands) to run simultaneously.
# Lower if your machine struggles with build
JOBS=$(nproc)

# Build output directory
M_OUT=out

# C Compiler
# Leave empty for gcc/clang
CC=

# 1 = Use LLVM toolchain
# 0 = Do not
# Most newer kernels will adopt this
LLVM=

# 1 = use GCC toolchain's assembler
# 0 = use Clang's integrated assembler
LLVM_IAS=

# ccache can speed up subsequent builds
# Set to 0 or 1
USE_CCACHE=1

# GCC toolchain prefix
# For example, if set to:
#       "x86_64-redhat-linux-"
# then the build system would use: 
#       x86_64-redhat-linux-gcc
#       x86_64-redhat-linux-as
#       x86_64-redhat-linux-ld
#       ...
CROSS_COMPILE=

# Target triple
# Only used by AOSP's clang
CLANG_TRIPLE=

# Changes the info of /proc/version
KBUILD_BUILD_TIMESTAMP=$(commit_time)
KBUILD_BUILD_HOST=build-host
KBUILD_BUILD_USER=build-user
KBUILD_BUILD_VERSION=1

# Inherit user configs
for dd in "." ".."; do
    ff=${scriptPWD}/${dd}/build.override
    if [[ -f "$ff" ]]; then
        set_colors
        eee "> Using config file:\n  $ff"
        . "$ff"
    fi
done
