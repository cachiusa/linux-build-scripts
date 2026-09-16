# The number of jobs (commands) to run simultaneously.
# Lower if your machine struggles with build
JOBS=$(nproc)

# Build output directory
OUT_DIR=out

# Target architecture
# Empty value will use build host's arch
ARCH=

# C Compiler
# Empty value will use clang/gcc
CC=

# Path to build toolchain
TC_HOME=

# GNU toolchain prefix
# For example, if set to:
#       "x86_64-redhat-linux-"
# then the kernel build system would use: 
#       x86_64-redhat-linux-gcc
#       x86_64-redhat-linux-ld
#       ...
CROSS_COMPILE=

# Target triple
# Only used by AOSP version of Clang
CLANG_TRIPLE=

# 1 = Use LLVM toolchain
# 0 = Do not
# Most newer kernels will adopt this
LLVM=

# 1 = use GCC toolchain's assembler
# 0 = use Clang's integrated assembler
LLVM_IAS=

# ccache can speed up subsequent builds
# Set to 0 or 1
USE_CCACHE=

# The "template" kernel config file
# When .config file is generated, feature selections in this file will be preferred.
DEFCONFIG=

# Build targets
# Run 'make help' for available targets. Items marked with '*' will be built if this array is empty
M_TARGETS=()

# Commands to run after .config file is generated
POST_DEFCONFIG_CMDS=()

# Commands to run after kernel build
POST_DEFCONFIG_CMDS=()

# Set the metadata shown in /proc/version
KBUILD_BUILD_TIMESTAMP=$(commit_time)
KBUILD_BUILD_HOST=build-host
KBUILD_BUILD_USER=build-user
KBUILD_BUILD_VERSION=1

# Inherit user configs
# Do not change unless you know what you're doing
for dd in "." ".."; do
    ff=${scriptPWD}/${dd}/Build.options
    if [[ -f "$ff" ]]; then
        set_colors
        eee "> Using config file:\n  $ff"
        . "$ff"
    fi
done
