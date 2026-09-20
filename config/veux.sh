# shellcheck disable=all
TC_HOME=$PWD/../llvm/bin
USE_CCACHE=1

ARCH=arm64

LLVM=1
LLVM_IAS=1
LTO=thin

DEFCONFIG=veux_defconfig
M_TARGETS=(
    Image
    dtbs
)
POST_DEFCONFIG_CMDS=(
    "configure -e KSU"
    "configure_droidspaces gki"
)
configure_inject_ramdisk() {
    configure \
        -e RD_LZMA \
        -e INITRAMFS_FORCE \
        -e INITRAMFS_FORCE_RECOVERY \
 --set-str INITRAMFS_SOURCE "source/usr/ramdisk.cpio" \
        -e INITRAMFS_COMPRESSION_LZMA
}