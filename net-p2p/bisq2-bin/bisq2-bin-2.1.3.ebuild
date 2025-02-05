EAPI=8

inherit desktop unpacker xdg-utils

DESCRIPTION="Bisq 2: The Decentralized Trading Platform"
HOMEPAGE="https://bisq.network/ https://github.com/bisq-network/bisq2/"
SRC_URI="https://github.com/bisq-network/bisq2/releases/download/v${PV}/Bisq-${PV}.deb"

LICENSE="GPLv3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="
	app-crypt/libmd
	dev-libs/libbsd
	media-libs/alsa-lib
	sys-libs/zlib
	x11-libs/libX11
	x11-libs/libXau
	x11-libs/libXdmcp
	x11-libs/libXext
	x11-libs/libXi
	x11-libs/libXrender
	x11-libs/libXtst
	x11-libs/libxcb
	x11-misc/xdg-utils
"

RESTRICT="mirror strip"

QA_PREBUILT="opt/bisq2/bin/Bisq opt/bisq2/lib/libapplauncher.soo opt/bisq2/lib/runtime/lib/*"
#REQUIRES_EXCLUDE=""

S="${WORKDIR}"

src_unpack() {
	unpack_deb "${A}"
}

src_compile() {
	:
}

src_install() {
	dodir /opt
	sed -i -E 's@^Categories=Network$@Categories=Office\;Finance\;P2P\;Network\;@' "${S}"/opt/bisq2/lib/bisq2-Bisq2.desktop
	cp -ar "${S}"/opt/bisq2 "${ED}"/opt/
	dosym ../bisq2/bin/Bisq2 /opt/bin/Bisq2
	domenu opt/bisq2/lib/bisq2-Bisq2.desktop
        doicon opt/bisq2/lib/Bisq2.png
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_icon_cache_update
	xdg_mimeinfo_database_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_icon_cache_update
	xdg_mimeinfo_database_update
}
