#!/bin/bash
# diy-part1.sh —— 在 openwrt 源码根目录执行（由 workflow cd 进去后调用 ../diy-part1.sh）
# 作用：补足 feeds.conf.default，添加 PassWall 必要的两个第三方源。
#
# ⚠️ 重要事实（与上方注释不同，以本段为准）：
#   OpenWrt/ImmortalWrt 标准 5 源里，luci-app-passwall 本身在 luci 源（有 Makefile），但其 LUCI_DEPENDS 引用的
#   后端工具包（chinadns-ng / dns2socks / microsocks / ipt2socks / tcping / kmod-nft-socket 等）以及
#   passwall 核心 backend（packages/passwall）都不在标准源里。它们在 xiaorouji/openwrt-passwall.git 与
#   xiaorouji/openwrt-passwall-packages.git（这两个独立仓库，由 Openwrt-Passwall 团队维护）。
#   不加这两个源 → luci-app-passwall 的 LUCI_DEPENDS 自动选不全 → make defconfig 直接把它丢弃 → 全家桶永远进不来。
#
#   2025-12 起的 luci-app-passwall v25+ 已采用"前 LUCI_DEPENDS 自动选依赖包"模式，所以同样需要这些源存在，
#   而不是手动在 .config 里写 +chinadns-ng=y。
#
#   这两个源只有 luci-app-passwall 单独需要，与 immortalwrt/luci 源无冲突（不重名）。
set -e

echo "==> [diy-part1] 追加 PassWall 必要源到 feeds.conf.default"
cat >> openwrt/feeds.conf.default <<'EOF'

# ────────── PassWall 全套源（xiaorouji/openwrt-passwall 官方仓库）──────────
src-git passwall_packages https://github.com/xiaorouji/openwrt-passwall-packages.git;main
src-git passwall https://github.com/xiaorouji/openwrt-passwall.git;main
EOF

echo "==> [diy-part1] 当前 feeds.conf.default 末尾："
tail -4 openwrt/feeds.conf.default
echo "==> [diy-part1] 完成"
