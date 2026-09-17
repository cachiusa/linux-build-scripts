configure_lto() {
    # If set to "full", force any kernel with LTO_CLANG support to be built
    # with full LTO, which is the most optimized method. This is the default,
    # but can result in very slow build times, especially when building
    # incrementally. (This mode does not require CFI to be disabled.)

    # If set to "thin", force any kernel with LTO_CLANG support to be built
    # with ThinLTO, which trades off some optimizations for incremental build
    # speed. This is nearly always what you want for local development. (This
    # mode does not require CFI to be disabled.)

    # If set to "none", force any kernel with LTO_CLANG support to be built
    # without any LTO (upstream default), which results in no optimizations
    # and also disables LTO-dependent features like CFI. This mode is not
    # recommended because CFI will not be able to catch bugs if it is
    # disabled.
    eee "  Modifying LTO mode to '${LTO}'"
    if [[ $1 = "none" ]]; then
        configure -d LTO_CLANG -e LTO_NONE -d LTO_CLANG_THIN -d LTO_CLANG_FULL -d THINLTO --set-val FRAME_WARN 0
    elif [[ $1 = "thin" ]]; then
        configure -e LTO_CLANG -d LTO_NONE -e LTO_CLANG_THIN -d LTO_CLANG_FULL -e THINLTO 
    elif [[ $1 = "full" ]]; then
        configure -e LTO_CLANG -d LTO_NONE -d LTO_CLANG_THIN -e LTO_CLANG_FULL -d THINLTO 
    else
        echo "LTO must be one of 'none', 'thin' or 'full'."
        exit 1
    fi
}
configure_droidspaces() {
    local opt=()
    # https://github.com/ravindu644/Droidspaces-OSS/blob/main/Documentation/Kernel-Configuration.md
    if [[ $1 != "gki" ]]; then opt+=(
        -e ANDROID_PARANOID_NETWORK \
        -e BRIDGE \
        -e BRIDGE_NETFILTER \
        -e CGROUPS \
        -e CGROUP_DEVICE \
        -e CGROUP_FREEZER \
        -e CGROUP_NET_PRIO \
        -e CGROUP_PIDS \
        -e CGROUP_SCHED \
        -e FAIR_GROUP_SCHED \
        -e FW_LOADER \
        -e FW_LOADER_COMPRESS \
        -e FW_LOADER_USER_HELPER \
        -e IP_ADVANCED_ROUTER \
        -e IP_MULTIPLE_TABLES \
        -e IP_NF_FILTER \
        -e IP_NF_IPTABLES \
        -e IP_NF_NAT \
        -e IP_NF_TARGET_MASQUERADE \
        -e IP_NF_TARGET_REJECT \
        -e IP_NF_TARGET_ULOG \
        -e MEMCG \
        -e NAMESPACES \
        -e NETFILTER \
        -e NETFILTER_ADVANCED \
        -e NETFILTER_NETLINK_LOG \
        -e NETFILTER_NETLINK_QUEUE \
        -e NETFILTER_XT_MATCH_COMMENT \
        -e NETFILTER_XT_MATCH_CONNTRACK \
        -e NETFILTER_XT_MATCH_HASHLIMIT \
        -e NETFILTER_XT_MATCH_HL \
        -e NETFILTER_XT_MATCH_LIMIT \
        -e NETFILTER_XT_MATCH_MARK \
        -e NETFILTER_XT_MATCH_MULTIPORT \
        -e NETFILTER_XT_MATCH_OWNER \
        -e NETFILTER_XT_MATCH_PKTTYPE \
        -e NETFILTER_XT_MATCH_STATE \
        -e NETFILTER_XT_TARGET_MARK \
        -e NETFILTER_XT_TARGET_MASQUERADE \
        -e NETFILTER_XT_TARGET_NFLOG \
        -e NETFILTER_XT_TARGET_TCPMSS \
        -e NET_NS \
        -e NF_CONNTRACK \
        -e NF_CONNTRACK_IPV4 \
        -e NF_CONNTRACK_NETLINK \
        -e NF_NAT \
        -e NF_NAT_IPV4 \
        -e NF_NAT_REDIRECT \
        -e NF_TABLES \
        -e OVERLAY_FS \
        -e SECCOMP \
        -e SECCOMP_FILTER \
        -e SYSCTL \
        -e UTS_NS \
        -e VETH )
    fi
    opt+=(
        -e SYSVIPC \
        -e POSIX_MQUEUE \
        -e IPC_NS \
        -e PID_NS \
        -e DEVTMPFS \
        -e NETFILTER_XT_MATCH_ADDRTYPE \
        -e USER_NS \
        -e NETFILTER_XT_TARGET_REJECT \
        -e NETFILTER_XT_TARGET_LOG \
        -e NETFILTER_XT_MATCH_RECENT \
        -e IP_SET \
        -e IP_SET_HASH_IP \
        -e IP_SET_HASH_NET \
        -e NETFILTER_XT_SET \
        -e TMPFS_POSIX_ACL \
        -e TMPFS_XATTR
    )
    configure "${opt[@]}"
}
configure_kali() {
    # https://github.com/cyberknight777/android_kernel_nethunter
    configure -e NETHUNTER_SUPPORT
}
