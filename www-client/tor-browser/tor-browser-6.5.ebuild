# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit unpacker

# Major version

DESCRIPTION="The Tor Browser lets you use Tor on Windows, Mac OS X, or Linux without needing to install any software."
HOMEPAGE="https://www.torproject.org"

URL_32="https://www.torproject.org/dist/torbrowser/${PV}/tor-browser-linux32-${PV}_en-US.tar.xz"
URL_64="https://www.torproject.org/dist/torbrowser/${PV}/tor-browser-linux64-${PV}_en-US.tar.xz"

SRC_URI="
	amd64? ( ${URL_64} )
	x86? ( ${URL_32} )
"
RESTRICT="mirror"

LICENSE="BSD GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~amd64-fbsd ~arm ~arm64 ~hppa ~ia64 ~m68k ~mips ~nios2 ~ppc ~ppc64 ~s390 ~sh ~sparc ~sparc-fbsd ~x86 ~x86-fbsd"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}"

src_unpack() {
	unpack ${A} || die "Could not unpack source!"
	mv ${WORKDIR}/* ${WORKDIR}/${PN}
	return
}

src_install() {
	local TARGETDIR="/opt/${PN}"
	insinto "${TARGETDIR}"/
	exeinto "${TARGETDIR}"/
	dodir "${TARGETDIR}"

	doins -r ${S}/${PN}/Browser/* || die "Could not install!"

	doexe ${S}/${PN}/Browser/start-tor-browser
	doexe ${S}/${PN}/Browser/execdesktop
	doexe ${S}/${PN}/Browser/firefox
	doexe ${S}/${PN}/Browser/plugin-container
	doexe ${S}/${PN}/Browser/run-mozilla.sh
	doexe ${S}/${PN}/Browser/updater
	doexe ${S}/${PN}/Browser/webapprt-stub

	exeinto "${TARGETDIR}"/TorBrowser/Tor/
	doexe ${S}/${PN}/Browser/TorBrowser/Tor/tor

	exeinto "${TARGETDIR}"/TorBrowser/Tor/PluggableTransports/
	doexe ${S}/${PN}/Browser/TorBrowser/Tor/PluggableTransports/fteproxy.bin
	doexe ${S}/${PN}/Browser/TorBrowser/Tor/PluggableTransports/meek-*
	doexe ${S}/${PN}/Browser/TorBrowser/Tor/PluggableTransports/obfs4proxy
	doexe ${S}/${PN}/Browser/TorBrowser/Tor/PluggableTransports/obfsproxy.bin

	insinto /usr/share/pixmaps
	doins "${FILESDIR}"/torbrowser.png || die "Could not copy torbrowser.png"

	return
}

pkg_postinst() {
	xdg-desktop-menu install "${FILESDIR}"/abadonna-torbrowser.desktop || die "Could not register a menu item!"
	if [ -d /opt/${PN} ]; then
		chown `logname` -R /opt/${PN}/
	fi
	einfo " "
	einfo " ============================================== PLEASE NOTE =============================================="
	einfo " "
	einfo " Tor Browser has been installed with your local user permissions (chown `logname` -R /opt/${PN})."
	einfo " In case you have multiple users on this computer, please copy this installation to your \$HOME directory,"
	einfo " and update menu entry. "
	einfo " "
	einfo " In order to do so, please copy&paste as local user: "
	einfo " "
	einfo " 		cp -R /opt/${PN} \$HOME/${PN} "
	einfo " "
	einfo " ========================================================================================================="
	return
}

pkg_postrm() {
	xdg-desktop-menu uninstall "${FILESDIR}"/abadonna-torbrowser.desktop || die "Could not de-register a menu item!"
	return
}
