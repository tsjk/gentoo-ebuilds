EAPI=6

inherit linux-mod eutils

DESCRIPTION="Driver for Realtek RTL8188CUS (8188C, 8192C) chipset wireless cards"
HOMEPAGE="http://www.realtek.com.tw"
#SRC_URI="https://starterkit-org.googlecode.com/files/rtl8188C_8192C_usb_linux_v4.0.2_9000.20130911.tar.gz -> ${P}.tar.gz"
SRC_URI="https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/starterkit-org/rtl8188C_8192C_usb_linux_v4.0.2_9000.20130911.tar.gz -> ${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

KEYWORDS="~amd64 ~x86"
RESTRICT="mirror"

S="${WORKDIR}/rtl8188C_8192C_usb_linux_v4.0.2_9000.20130911"
MODULE_NAMES="8192cu(kernel/drivers/net/wireless/8192cu:)"
BUILD_TARGETS="modules"

CONFIG_CHECK="~!RTL8192CU ~!RTL8192C_COMMON ~!RTLWIFI"
ERROR_RTLWIFI="If you want to use ${P} you sould blacklist the standard kernel tree's rtlwifi, rtl8192c_common, and rtl8192cu modules"
ERROR_RTL8192C_COMMON="If you want to use ${P} you sould blacklist the standard kernel tree's rtlwifi, rtl8192c_common, and rtl8192cu modules"
ERROR_RTL8192CU="If you want to use ${P} you sould blacklist the standard kernel tree's rtlwifi, rtl8192c_common, and rtl8192cu modules"

PATCHES=( "${FILESDIR}/fix_310_proc2.patch" \
	"${FILESDIR}/N150MA.patch" \
	"${FILESDIR}/NoDebug.patch" \
	"${FILESDIR}/ISY.patch" \
	"${FILESDIR}/D-link.patch" \
	"${FILESDIR}/RTL8192CU-kernel-4.0.patch" )

pkg_setup() {
        linux-mod_pkg_setup
        BUILD_PARAMS="KSRC=${KV_DIR} KVER=${KV_FULL}"
}

src_install() {
        linux-mod_src_install
}
