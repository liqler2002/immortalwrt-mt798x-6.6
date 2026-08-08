#!/bin/bash
# diy-part2.sh —— 在 openwrt 源码根目录执行（由 workflow cd 进去后调用 ../diy-part2.sh）
# 作用：刷机后的默认参数（主题已通过 .config 的 CONFIG_DEFAULT_luci-theme-argon=y 设定）。
set -e

echo "==> [diy-part2] 设置默认参数"

# 1) 默认主题：已在 .config 用 CONFIG_DEFAULT_luci-theme-argon=y 设定，无需手动 sed。
#    旧写法 `sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile`
#    在 24.10 路径已变更（集合拆成了 luci-light / luci-ssl-nginx 等），会失效或报错，故弃用。

# 2) BBR 兜底：即使 turboacc 的 BBR 子项没生效，也强制内核默认拥塞控制用 BBR。
#    （BBR 已内置于 6.6 内核，这里只是改默认值）
mkdir -p files/etc/sysctl.d
cat > files/etc/sysctl.d/30-bbr.conf <<'EOF'
net.core.default_qdisc=fq
net.ipv4.tcp_congestion_control=bbr
EOF

# 3) （可选）修改默认 LAN IP。fork 默认已是 192.168.1.1，通常无需改。
#    如需改成 192.168.10.1，取消下面一行：
# sed -i 's/192.168.1.1/192.168.10.1/g' package/base-files/files/bin/config_generate

echo "==> [diy-part2] 完成"
