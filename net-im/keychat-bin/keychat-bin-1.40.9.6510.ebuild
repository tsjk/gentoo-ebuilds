EAPI=8

inherit desktop unpacker xdg-utils

DESCRIPTION="Keychat is the super app for Bitcoiners. Autonomous IDs, Bitcoin ecash wallet, secure chat, and rich mini apps — all in Keychat. Autonomy. Security. Richness."
HOMEPAGE="https://www.keychat.io/ https://github.com/keychat-io/keychat-app/"
SRC_URI="https://github.com/keychat-io/keychat-app/releases/download/v1.40.9+6510/Keychat-1.40.9+6510-linux-amd64.deb"

LICENSE="GPLv3"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="
	app-crypt/libsecret[crypt]
	dev-libs/jsoncpp"

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
	cp -ar "${S}"/usr/share/keychat "${ED}"/opt/
	dosym ../keychat/keychat /opt/bin/keychat
	sed -i -E '/^Version=.*/d' "${S}"/usr/share/applications/keychat.desktop
	domenu usr/share/applications/keychat.desktop
	doicon -s 128 usr/share/icons/hicolor/128x128/apps/${PN%-bin}.png
	doicon -s 256 usr/share/icons/hicolor/256x256/apps/${PN%-bin}.png
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
