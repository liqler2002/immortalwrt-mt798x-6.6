#!/bin/bash
# diy-part1.sh —— 在 openwrt 源码根目录执行（由 workflow cd 进去后调用 ../diy-part1.sh）
# 作用：本应拉取第三方源码；但经核实，当前所需全部包已在上游源中，克隆反而会与上游源冲突。
#
# ⚠️ 重要修正（防编译失败）：
#   kalicyh 的 feeds.conf.default 已含 immortalwrt/luci 源，其中【自带 luci-app-passwall】(版本 25.12.16)；
#   而 Openwrt-Passwall/openwrt-passwall 也提供同名 luci-app-passwall（26.8.1）。
#   若再 git clone openwrt-passwall，会出现 “package luci-app-passwall is in both …” 重复包错误 → make 直接失败。
#   同理 openwrt-passwall-packages 提供的 xray-core 与 immortalwrt/packages 源的 xray-core 重名 → 也会冲突。
#   故：PassWall GUI + 后端、以及 xray-core 等协议二进制，全部直接用上游源（luci 源 + packages 源），
#   不克隆任何 PassWall 仓库。INCLUDE_Xray 所需的 xray-core 由 packages 源（Go 1.23 兼容）提供，无 Go 1.25 冲突。
#
#   若日后想要更新的 PassWall（26.x）：不要直接 clone，而应改 feeds.conf.default 把 luci 源换成
#   Openwrt-Passwall 的 luci 分支，或 fork 后用 scripts/feeds 覆盖——否则必冲突。
set -e

echo "==> [diy-part1] 无需额外克隆：PassWall / xray 等均已在 immortalwrt luci+packages 源中"
echo "==> [diy-part1] 完成"
