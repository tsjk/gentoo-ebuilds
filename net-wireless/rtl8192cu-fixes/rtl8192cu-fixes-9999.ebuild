EAPI=8

EGIT_REPO_URI="https://github.com/pvaret/rtl8192cu-fixes.git"

inherit git-r3 linux-mod

DESCRIPTION="Realtek 8192 chipset driver, ported to kernel 3.11+"
HOMEPAGE="https://github.com/pvaret/rtl8192cu-fixes"
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

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

	dodoc README.md *.conf
	einfo "Sample configuration files were installed to ${EPREFIX}/usr/share/doc/${PF}."
	einfo "Copy them to /etc/modprobe.d to enable"
	einfo "See README.md installed there for more info"
}
