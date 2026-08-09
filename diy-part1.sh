#!/bin/bash
# diy-part1.sh —— 在 openwrt 源码根目录执行（由 workflow cd 进去后调用 ../diy-part1.sh）
# 作用：拉取 .config 里需要的、但 padavanonly fork 默认不含的第三方源码。
set -e

echo "==> [diy-part1] 添加第三方包源"

# 1) PassWall + 依赖（padavanonly/immortalwrt-mt798x-6.6 默认不含，必须加）
git clone https://github.com/Openwrt-Passwall/openwrt-passwall-packages.git package/passwall_packages
# 删除 PassWall 第三方包集里追新的 xray-core，强制使用 ImmortalWrt 官方兼容版 xray-core
rm -rf package/passwall_packages/xray-core
git clone https://github.com/Openwrt-Passwall/openwrt-passwall.git package/passwall

# 2) Argon 主题：
#    padavanonly fork 一般已自带 luci-theme-argon / luci-app-argon-config，无需重复克隆。
#    若你换用的源码确实不含 argon，再取消下面两行；且【必须去掉 -b 18.06】，用默认 master 分支，
#    否则 18.06 分支是针对旧版 LuCI 的，在 24.10/ImmortalWrt 上编译会报错或主题损坏。
# git clone https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon
# git clone https://github.com/jerrykuku/luci-app-argon-config.git package/luci-app-argon-config

# 3) DDNS 厂商脚本 ddns-scripts-cloudflare / ddns-scripts-aliyun
#    ✅ 已确认在 OpenWrt 24.10 默认 feeds 内（菜单：Network → IP Addresses and Names），
#    无需额外源，.config 里已直接勾选，这里不用动。
#    （旧资料说需 Lienol 源是 21.02/22.03 时代的过时结论，24.10 已内置。）

echo "==> [diy-part1] 完成"
