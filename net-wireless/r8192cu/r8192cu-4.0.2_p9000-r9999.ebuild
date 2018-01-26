EAPI=6

inherit git-r3 linux-mod eutils

DESCRIPTION="Driver for Realtek RTL8188CUS (8188C, 8192C) chipset wireless cards"
HOMEPAGE="http://www.realtek.com.tw"
EGIT_REPO_URI="https://github.com/Rick-Moba/rtl8192cu.git"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

KEYWORDS="~amd64 ~x86"
RESTRICT="mirror"

S="${WORKDIR}/r8192cu-4.0.2_p9000"
MODULE_NAMES="8192cu(kernel/drivers/net/wireless/8192cu:)"
BUILD_TARGETS="modules"

CONFIG_CHECK="~!RTL8192CU ~!RTL8192C_COMMON ~!RTLWIFI"
ERROR_RTLWIFI="If you want to use ${P} you sould blacklist the standard kernel tree's rtlwifi, rtl8192c_common, and rtl8192cu modules"
ERROR_RTL8192C_COMMON="If you want to use ${P} you sould blacklist the standard kernel tree's rtlwifi, rtl8192c_common, and rtl8192cu modules"
ERROR_RTL8192CU="If you want to use ${P} you sould blacklist the standard kernel tree's rtlwifi, rtl8192c_common, and rtl8192cu modules"

pkg_setup() {
        linux-mod_pkg_setup
        BUILD_PARAMS="KSRC=${KV_DIR} KVER=${KV_FULL}"
}

src_install() {
        linux-mod_src_install
}
