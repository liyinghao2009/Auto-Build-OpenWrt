#!/bin/bash
#
# Copyright (c) 2019-2024 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# 修改默认IP
sed -i 's/192.168.1.1/192.168.10.1/g' package/base-files/files/bin/config_generate


# 修改默认主题
#sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' ./feeds/luci/collections/luci/Makefile

# 取消bootstrap为默认主题
sed -i '/set luci.main.mediaurlbase=\/luci-static\/bootstrap/d' feeds/luci/themes/luci-theme-bootstrap/root/etc/uci-defaults/30_luci-theme-bootstrap

# 修改主机名称
#sed -i 's/OpenWrt/YingHaoIT-ROS/g' package/base-files/files/bin/config_generate

# 加入作者信息
sed -i "s/DISTRIB_REVISION='*.*'/DISTRIB_REVISION='YingHaoIT-ROS-$(date +%Y%m%d) 定制版'/g" package/base-files/files/etc/openwrt_release 
sed -i "s/DISTRIB_DESCRIPTION='*.*'/DISTRIB_DESCRIPTION='YingHaoIT-ROS-$(date +%Y%m%d) 定制版'/g"  package/base-files/files/etc/openwrt_release 

# 修改版本号
sed -i "s/OpenWrt /YingHaoIT-ROS $(TZ=UTC-8 date "+%Y.%m.%d")/g" package/lean/default-settings/files/zzz-default-settings

# 修改默认wifi名称ssid为tymishop
#sed -i 's/ssid=OpenWrt/ssid=wifi/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh

# 开启MU-MIMO
#sed -i 's/mu_beamformer=0/mu_beamformer=1/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh

# wifi加密方式，没有是none
#sed -i 's/encryption=none/encryption=psk2/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh

# wifi密码
#sed -i 's/key=15581822425/key=88888888/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh

# 修改依赖版本只针对fros插件
sed -i 's/PKG_SOURCE_DATE:=*.*/PKG_SOURCE_DATE:=2022-09-27/g' package/libs/libubox/Makefile
sed -i 's/PKG_MIRROR_HASH:=*.*/PKG_MIRROR_HASH:=400bef38b8c0f382e4e595a50bb52dfbdb8da820eb80f3447b9bd7be3f5499a5/g' package/libs/libubox/Makefile
sed -i 's/PKG_SOURCE_VERSION:=*.*/PKG_SOURCE_VERSION:=ea56013409d5823001b47a9bba6f74055a6d76a5/g' package/libs/libubox/Makefile
sed -i 's/PKG_SOURCE_DATE:=*.*/PKG_SOURCE_DATE:=2022-06-15/g' package/system/ubus/Makefile
sed -i 's/PKG_SOURCE_VERSION:=*.*/PKG_SOURCE_VERSION:=9913aa61de739e3efe067a2d186021c20bcd65e2' package/system/ubus/Makefile
sed -i 's/PKG_MIRROR_HASH:=*.*/PKG_MIRROR_HASH:=f6702e68d7c60388c11f40ca5ca8e932d0bf423325db5bee2c79404782bbcb52' package/system/ubus/Makefile


# 修改网口wan=eth0 lan=eth1
sed -i "s/ucidef_set_interface_lan 'eth1'/ucidef_set_interface_lan 'eth0'/g" package/base-files/files/etc/board.d/99-default_network
sed -i "s/ucidef_set_interface_wan 'eth0'/ucidef_set_interface_wan 'eth1'/g" package/base-files/files/etc/board.d/99-default_network

# 修改制造商
sed -i 's/default "OpenWrt"/default "YingHaoIT-ROS"/g' config/Config-images.in


# 修改固件包名称
sed -i 's/VERSION_DIST:=$(if $(VERSION_DIST),$(VERSION_DIST),OpenWrt)/VERSION_DIST:=$(if $(VERSION_DIST),$(VERSION_DIST),YingHaoIT-ROS)/g' include/version.mk
sed -i 's/VERSION_MANUFACTURER:=$(if $(VERSION_MANUFACTURER),$(VERSION_MANUFACTURER),OpenWrt)/VERSION_MANUFACTURER:=$(if $(VERSION_MANUFACTURER),$(VERSION_MANUFACTURER),YingHaoIT-ROS)/g' include/version.mk




# Add kernel build user
[ -z $(grep "CONFIG_KERNEL_BUILD_USER=" .config) ] &&
    echo 'CONFIG_KERNEL_BUILD_USER="MOLUN"' >>.config ||
    sed -i 's@\(CONFIG_KERNEL_BUILD_USER=\).*@\1$"MOLUN"@' .config

# Add kernel build domain
[ -z $(grep "CONFIG_KERNEL_BUILD_DOMAIN=" .config) ] &&
    echo 'CONFIG_KERNEL_BUILD_DOMAIN="GitHub Actions"' >>.config ||
    sed -i 's@\(CONFIG_KERNEL_BUILD_DOMAIN=\).*@\1$"GitHub Actions"@' .config
