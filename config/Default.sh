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

# -- Required --
# The "template" kernel config file. When .config file is generated, feature selections in this file will be honored.
# You can find one in:
#     arch/< kernel arch >/configs
# If you don't know what to choose, just fill this with "defconfig"
DEFCONFIG=

# Build targets
# Run './build/make help' for available targets.
# Empty array means you will build all items marked with (*)
M_TARGETS=()

# C Compiler
# Empty value infers the use of clang/gcc
CC=

# Path to build toolchain
# Empty value means system installed toolchain will be used (or whatever is in your PATH)
TC_HOME=

# GNU toolchain prefix
#   For example, if set to:
#       "x86_64-redhat-linux-"
#   then the kernel build system would use: 
#       x86_64-redhat-linux-gcc
#       x86_64-redhat-linux-ld
#       ...
# Has no effect when LLVM=1
CROSS_COMPILE=

# Target triple
# Only used by Android's fork of Clang/LLVM
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

# Commands to run after .config file is generated
POST_DEFCONFIG_CMDS=()

# Commands to run after kernel build
POST_DEFCONFIG_CMDS=()

# Set the metadata shown in /proc/version
KBUILD_BUILD_TIMESTAMP=$(commit_time)
KBUILD_BUILD_HOST=build-host
KBUILD_BUILD_USER=build-user
KBUILD_BUILD_VERSION=1

# Control Clang/LLVM's Link Time Optimization
# Set to "none", "thin", or "full"
# https://wiki.gentoo.org/wiki/LTO#Terminology
# Empty value means your DEFCONFIG will decide.
LTO=
