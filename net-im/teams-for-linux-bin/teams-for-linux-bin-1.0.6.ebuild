EAPI=7

inherit desktop eutils unpacker xdg-utils

DESCRIPTION="Unofficial Microsoft Teams client for Linux using Electron. It uses the Web App and wraps it as a standalone application using Electron"
HOMEPAGE="https://github.com/IsmaelMartinez/teams-for-linux"
SRC_URI="https://github.com/IsmaelMartinez/${PN%-bin}/releases/download/v${PV}/${PN%-bin}_${PV}_amd64.deb"

LICENSE="GPLv3"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="
	app-accessibility/at-spi2-core[X]
	app-arch/gzip
	app-crypt/libsecret
	dev-libs/libappindicator
	dev-libs/nss
	sys-apps/util-linux
	x11-libs/gtk+:3
	x11-libs/libXScrnSaver
	x11-libs/libXtst
	x11-libs/libnotify
	x11-misc/xdg-utils
"

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
	cp -ar "${S}/opt/${PN%-bin}" "${ED}"/opt/
	dosym ../${PN%-bin}/${PN%-bin} /opt/bin/${PN%-bin}
	dodir /usr/share
	gzip -d "${S}/usr/share/doc/teams-for-linux/changelog.gz"
	mv "${S}/usr/share/doc/teams-for-linux" "${S}/usr/share/doc/${P}"
	cp -ar "${S}/usr/share"/* "${ED}"/usr/share/
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
