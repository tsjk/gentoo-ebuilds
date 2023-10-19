EAPI=8

inherit desktop unpacker xdg-utils

DESCRIPTION="Wasabi is an open-source, non-custodial, privacy-focused Bitcoin wallet for Desktop, that implements trustless CoinJoin"
HOMEPAGE="https://wasabiwallet.io/ https://github.com/zkSNACKs/WalletWasabi/"
SRC_URI="https://github.com/zkSNACKs/WalletWasabi/releases/download/v${PV}/Wasabi-${PV}.deb"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="
	dev-util/lttng-ust:0/2.12
	media-libs/fontconfig
	net-misc/curl
	x11-themes/hicolor-icon-theme"

RESTRICT="mirror strip"

S="${WORKDIR}"

src_unpack() {
	unpack_deb "${A}"
}

src_compile() {
	:
}

src_install() {
	dodir /opt
	cp -ar "${S}"/usr/local/bin/wasabiwallet "${ED}"/opt/
	dosym ../wasabiwallet/wassabee /opt/bin/wassabee
	domenu usr/share/applications/wassabee.desktop
	for x in 16 22 24 32 36 48 64 72 96 128 192 256 512
		do doicon -s ${x} usr/share/icons/hicolor/${x}*/*
        done
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
