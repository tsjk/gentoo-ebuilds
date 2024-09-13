# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop unpacker xdg-utils

DESCRIPTION="Lets you easily share a single mouse and keyboard between multiple computers"
HOMEPAGE="https://symless.com/synergy"
SRC_URI="synergy_1.14.6-stable.06a860d9_ubuntu22_amd64.deb"
S="${WORKDIR}"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="fetch"

RDEPEND="
	!x11-misc/synergy
	>=dev-libs/glib-2.12.0
	>=dev-libs/openssl-3.0.0:0/3
	>=dev-qt/qtcore-5.15.1:5
	>=dev-qt/qtdbus-5.14.1:5
	>=dev-qt/qtgui-5.2.0:5
	>=dev-qt/qtnetwork-5.0.2:5
	>=dev-qt/qtwidgets-5.15.1:5
	x11-libs/gdk-pixbuf
	x11-libs/libICE
	x11-libs/libSM
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXi
	x11-libs/libXinerama
	x11-libs/libXrandr
	x11-libs/libXtst
	x11-libs/libnotify
	x11-libs/libxkbfile
"

QA_PREBUILT="
	usr/bin/*
"

pkg_nofetch() {
	einfo "Please buy and download ${SRC_URI} from:"
	einfo "  https://symless.com"
	einfo "and move it to your distfiles directory."
}

src_unpack() {
	unpack_deb "${A}"
}

src_install() {
	insinto /usr/bin
	dobin usr/bin/*
	mv usr/share/doc/synergy usr/share/doc/${PN}
	gzip -d usr/share/doc/${PN}/changelog.gz
	dodoc usr/share/doc/${PN}/*
	mv usr/share/icons/hicolor/scalable/apps/synergy.svg usr/share/icons/hicolor/scalable/apps/${PN}.svg
	doicon -s scalable usr/share/icons/hicolor/scalable/apps/${PN}.svg
	mv usr/share/applications/synergy.desktop usr/share/applications/${PN}.desktop
	sed -i "s/^Icon=synergy$/Icon=${PN}/" usr/share/applications/${PN}.desktop || die "Failed to update desktop file"
	domenu usr/share/applications/${PN}.desktop
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}
