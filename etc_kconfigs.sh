configure_lto() {
    if [ "${1}" = "none" ]; then
        configure -d LTO_CLANG -e LTO_NONE -d LTO_CLANG_THIN -d LTO_CLANG_FULL -d THINLTO --set-val FRAME_WARN 0
    elif [ "${1}" = "thin" ]; then
        configure -e LTO_CLANG -d LTO_NONE -e LTO_CLANG_THIN -d LTO_CLANG_FULL -e THINLTO 
    elif [ "${1}" = "full" ]; then
        configure -e LTO_CLANG -d LTO_NONE -d LTO_CLANG_THIN -e LTO_CLANG_FULL -d THINLTO 
    fi
}
configure_droidspaces() {
    # https://github.com/ravindu644/Droidspaces-OSS/blob/main/Documentation/Kernel-Configuration.md#configuring-non-gki-kernels-legacy-kernels
    configure \
    -e SYSCTL \
    -e SYSVIPC \
    -e POSIX_MQUEUE \
    -e NAMESPACES \
    -e PID_NS \
    -e UTS_NS \
    -e IPC_NS \
    -e SECCOMP \
    -e SECCOMP_FILTER \
    -e CGROUPS \
    -e CGROUP_DEVICE \
    -e CGROUP_PIDS \
    -e MEMCG \
    -e CGROUP_SCHED \
    -e FAIR_GROUP_SCHED \
    -e CGROUP_FREEZER \
    -e CGROUP_NET_PRIO \
    -e DEVTMPFS \
    -e OVERLAY_FS \
    -e TMPFS_POSIX_ACL \
    -e TMPFS_XATTR \
    -e FW_LOADER \
    -e FW_LOADER_USER_HELPER \
    -e FW_LOADER_COMPRESS \
    -e NET_NS \
    -e VETH \
    -e BRIDGE \
    -e NETFILTER \
    -e BRIDGE_NETFILTER \
    -e NETFILTER_ADVANCED \
    -e NF_CONNTRACK \
    -e IP_NF_IPTABLES \
    -e IP_NF_FILTER \
    -e NF_NAT \
    -e NF_TABLES \
    -e IP_NF_TARGET_MASQUERADE \
    -e NETFILTER_XT_TARGET_MASQUERADE \
    -e NETFILTER_XT_TARGET_TCPMSS \
    -e NETFILTER_XT_MATCH_ADDRTYPE \
    -e NF_CONNTRACK_NETLINK \
    -e NF_NAT_REDIRECT \
    -e IP_ADVANCED_ROUTER \
    -e IP_MULTIPLE_TABLES \
    -e NF_CONNTRACK_IPV4 \
    -e NF_NAT_IPV4 \
    -e IP_NF_NAT \
    -d ANDROID_PARANOID_NETWORK \
    -e USER_NS \
    -e NETFILTER_XT_MATCH_COMMENT \
    -e NETFILTER_XT_MATCH_STATE \
    -e NETFILTER_XT_MATCH_CONNTRACK \
    -e NETFILTER_XT_MATCH_MULTIPORT \
    -e NETFILTER_XT_MATCH_HL \
    -e NETFILTER_XT_TARGET_REJECT \
    -e IP_NF_TARGET_REJECT \
    -e NETFILTER_XT_TARGET_LOG \
    -e IP_NF_TARGET_ULOG \
    -e NETFILTER_XT_MATCH_RECENT \
    -e NETFILTER_XT_MATCH_LIMIT \
    -e NETFILTER_XT_MATCH_HASHLIMIT \
    -e NETFILTER_XT_MATCH_OWNER \
    -e NETFILTER_XT_MATCH_PKTTYPE \
    -e NETFILTER_XT_MATCH_MARK \
    -e NETFILTER_XT_TARGET_MARK \
    -e IP_SET \
    -e IP_SET_HASH_IP \
    -e IP_SET_HASH_NET \
    -e NETFILTER_XT_SET \
    -e NETFILTER_NETLINK_QUEUE \
    -e NETFILTER_NETLINK_LOG \
    -e NETFILTER_XT_TARGET_NFLOG
}
configure_droidspaces_gki() {
    # https://github.com/ravindu644/Droidspaces-OSS/blob/main/Documentation/Kernel-Configuration.md#configuring-gki-kernels
    configure \
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
}
