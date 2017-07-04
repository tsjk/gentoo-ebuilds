# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6
inherit eutils fdo-mime gnome2-utils pax-utils unpacker

DESCRIPTION="Spotify is a social music platform"
HOMEPAGE="https://www.spotify.com/ch-de/download/previews/"
MY_PV="${PV}.gca9c9538"
MY_P="${PN}-client_${MY_PV}"
SRC_BASE="http://repository.spotify.com/pool/non-free/${PN:0:1}/${PN}-client/"
SRC_URI="amd64? ( ${SRC_BASE}${MY_P}-30_amd64.deb )
	x86? ( ${SRC_BASE}${MY_P}-30_i386.deb )"
LICENSE="Spotify"
SLOT="1.0"
KEYWORDS="~amd64 ~x86"
IUSE="gnome pax_kernel pulseaudio"
RESTRICT="mirror strip"

DEPEND=""
# zenety needed for filepicker
RDEPEND="
	${DEPEND}
	dev-libs/nss
	dev-python/pygobject:3
	dev-python/dbus-python
	gnome-base/gconf
	gnome-extra/zenity
	media-libs/alsa-lib
	media-libs/harfbuzz
	media-libs/fontconfig
	media-libs/mesa
	net-misc/curl[ssl]
	net-print/cups[ssl]
	x11-libs/gtk+:2
	x11-libs/libXScrnSaver
	x11-libs/libXtst
	pulseaudio? ( media-sound/pulseaudio )
	gnome? ( gnome-extra/gnome-integration-spotify )"
	#sys-libs/glibc

S=${WORKDIR}/

QA_PREBUILT="usr/share/spotify/spotify"

src_prepare() {
	# Fix desktop entry to launch spotify-dbus.py for GNOME integration
	if use gnome ; then
	sed -i \
		-e 's/spotify \%U/spotify-dbus.py \%U/g' \
		usr/share/spotify/spotify.desktop || die "sed failed"
	fi

	default
}

src_install() {
	rm -f usr/share/spotify/spotify.desktop
	dodoc usr/share/doc/spotify-client/changelog.gz

	SPOTIFY_PKG_HOME=usr/share/spotify
	insinto /usr/share/spotify/icons
	doins ${SPOTIFY_PKG_HOME}/icons/*.png

	SPOTIFY_HOME=/usr/share/spotify
	insinto ${SPOTIFY_HOME}
	doins -r ${SPOTIFY_PKG_HOME}/*
	fperms +x ${SPOTIFY_HOME}/spotify

	dodir /usr/bin
	cat <<-EOF >"${D}"/usr/bin/spotify-client
		#! /bin/sh
		exec ${SPOTIFY_HOME}/spotify "\$@"
	EOF
	fperms +x /usr/bin/spotify-client

	for size in 16 22 24 32 48 64 128 256; do
			newicon -s ${size} "${FILESDIR}/icons/spotify-linux-${size}.png" \
						"spotify_client.png"
							done

        make_desktop_entry "spotify-client" "Spotify Client (v${MY_PV})" "spotify_client"
        domenu "${S}${SPOTIFY_HOME}/spotify-client.desktop"

	if use pax_kernel; then
		#create the headers, reset them to default, then paxmark -m them
		pax-mark C "${ED}${SPOTIFY_HOME}/${PN}" || die
		pax-mark z "${ED}${SPOTIFY_HOME}/${PN}" || die
		pax-mark m "${ED}${SPOTIFY_HOME}/${PN}" || die
		eqawarn "You have set USE=pax_kernel meaning that you intend to run"
		eqawarn "${PN} under a PaX enabled kernel.  To do so, we must modify"
		eqawarn "the ${PN} binary itself and this *may* lead to breakage!  If"
		eqawarn "you suspect that ${PN} is being broken by this modification,"
		eqawarn "please open a bug."
	fi
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	gnome2_icon_cache_update
	fdo-mime_mime_database_update
	fdo-mime_desktop_database_update
}

pkg_postrm() {
	gnome2_icon_cache_update
	fdo-mime_mime_database_update
	fdo-mime_desktop_database_update
}
