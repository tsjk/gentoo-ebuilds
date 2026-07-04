EAPI=8

inherit linux-mod-r1

DESCRIPTION="IBM ThinkPad SMAPI BIOS driver"
HOMEPAGE="https://github.com/linux-thinkpad/tp_smapi"
if [ "${PV}" = "9999" ]; then
        inherit git-r3
        EGIT_REPO_URI="https://github.com/linux-thinkpad/tp_smapi.git"
        KEYWORDS=""
else
        SRC_URI="https://github.com/linux-thinkpad/tp_smapi/releases/download/tp-smapi/${PV}/${P}.tgz"
        KEYWORDS="amd64 x86"
fi


LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"

IUSE="hdaps"

pkg_setup() {
	if use hdaps; then
		local CONFIG_CHECK="~INPUT_UINPUT"
		local WARNING_INPUT_UINPUT="Your kernel needs uinput for the hdaps module to perform better"
		local CONFIG_CHECK="~!SENSORS_HDAPS"
		local ERROR_SENSORS_HDAPS="${P} with USE=hdaps conflicts with in-kernel HDAPS (CONFIG_SENSORS_HDAPS)"
	fi

	linux-mod-r1_pkg_setup
}

src_compile() {
	local modlist=( thinkpad_ec tp_smapi )
	local modargs=( KSRC=${KV_DIR} KBUILD=${KV_OUT_DIR} )

	if use hdaps; then
		modlist+=( hdaps )
		modargs+=( HDAPS=1 )
	fi

	linux-mod-r1_src_compile
}

src_install() {
	linux-mod-r1_src_install

	newinitd "${FILESDIR}/${PN}-0.40-initd" smapi
	newconfd "${FILESDIR}/${PN}-0.40-confd" smapi
}
