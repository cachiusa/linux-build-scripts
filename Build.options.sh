# shellcheck disable=all

# This file contains default build options and should only be used for reference
#
# If you want to override these settings, create a `Build.options` file 
#    in the same directory as the build scripts,
# or in the root of your kernel tree.

# Build output directory
# On newer versions of Qualcomm/CAF's Linux fork, you must specify an out folder.
# https://github.com/LinuxPanda/android_kernel_xiaomi_rosy/pull/4
KBUILD_OUTPUT=out

# Target architecture
# Empty value will use build host's arch
ARCH=

# C Compiler
# Empty value infers the use of clang/gcc
CC=

# Path to build toolchain
# Empty value means system installed toolchain will be used
TC_HOME=

# GNU toolchain prefix
# For example, if set to:
#       "x86_64-redhat-linux-"
# then the kernel build system would use: 
#       x86_64-redhat-linux-gcc
#       x86_64-redhat-linux-ld
#       ...
# Has no effect when LLVM=1 is set
CROSS_COMPILE=

# Target triple
# Only used by Android version of Clang
# https://lkml.org/lkml/2021/9/9/136
CLANG_TRIPLE=

# 1 = use LLVM toolchain
# 0 = use GNU toolchain (default)
# Most newer kernels (especially Android) will adopt this
# https://android.googlesource.com/platform/prebuilts/clang/host/linux-x86/+/master/BINUTILS_KERNEL_DEPRECATION.md
LLVM=

# 1 = use Clang's integrated assembler (default since Linux 5.15)
# 0 = do not
# https://github.com/torvalds/linux/commit/f12b034afeb3a977bbb1c6584dedc0f3dc666f14
LLVM_IAS=

# ccache can speed up subsequent builds
# https://nickdesaulniers.github.io/blog/2018/06/02/speeding-up-linux-kernel-builds-with-ccache/
# 1 = enable
# 0 = Do not (default)
USE_CCACHE=

##### Required
# The "template" kernel config file
# When .config file is generated, feature selections in this file will be preferred.
DEFCONFIG=

# Build targets
# Run './build/make help' for available targets. Items marked with * will be built if this array is empty
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
if [[ -f ${BUILD_CONFIG} ]]; then
    eH "  Using config file: $BUILD_CONFIG"
    . "$BUILD_CONFIG"
else
    for dd in "$scriptPWD" "$PWD"; do
        ff=$dd/Build.options
        if [[ -f "$ff" ]]; then
            eH "  Using config file: $ff"
            . "$ff"
        fi
    done
fi
