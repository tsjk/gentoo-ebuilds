# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:

EAPI=5

inherit linux-mod eutils

DESCRIPTION="Driver for Realtek RTL8188CUS (8188C, 8192C) chipset wireless cards"
HOMEPAGE="http://www.realtek.com.tw"
SRC_URI="https://starterkit-org.googlecode.com/files/rtl8188C_8192C_usb_linux_v4.0.2_9000.20130911.tar.gz -> ${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

KEYWORDS="~amd64 ~x86"
RESTRICT="mirror"

S="${WORKDIR}/rtl8188C_8192C_usb_linux_v4.0.2_9000.20130911"
MODULE_NAMES="8192cu(net:${S})"
BUILD_TARGETS="modules"

CONFIG_CHECK="~!RTL8192CU ~!RTL8192C_COMMON ~!RTLWIFI"
ERROR_RTLWIFI="If you want to use ${P} you sould blacklist the standard kernel tree's rtlwifi, rtl8192c_common, and rtl8192cu modules"
ERROR_RTL8192C_COMMON="If you want to use ${P} you sould blacklist the standard kernel tree's rtlwifi, rtl8192c_common, and rtl8192cu modules"
ERROR_RTL8192CU="If you want to use ${P} you sould blacklist the standard kernel tree's rtlwifi, rtl8192c_common, and rtl8192cu modules"

src_prepare() {
	epatch "${FILESDIR}/fix_310_proc2.patch"
	epatch "${FILESDIR}/N150MA.patch"
	epatch "${FILESDIR}/NoDebug.patch"
	epatch "${FILESDIR}/ISY.patch"
	epatch "${FILESDIR}/D-link.patch"
	epatch "${FILESDIR}/RTL8192CU-kernel-4.0.patch"
}

pkg_setup() {
        linux-mod_pkg_setup
        BUILD_PARAMS="KERNELDIR=${KV_DIR}"
}

src_install() {
        linux-mod_src_install
        dodoc README
}
