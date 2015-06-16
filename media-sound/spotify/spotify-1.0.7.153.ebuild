EAPI=5
inherit eutils gnome2-utils fdo-mime pax-utils unpacker

DESCRIPTION="Spotify beta is a proprietary music streaming platform"
HOMEPAGE="https://www.spotify.com/download/previews/"
MY_PN="spotify-client"
MY_PV="${PV}.gb9e8174a"
MY_P="${MY_PN}_${MY_PV}"
SRC_URI="http://repository.spotify.com/pool/non-free/s/${MY_PN}/${MY_P}_amd64.deb"
LICENSE="Spotify"
SLOT="1.0"
KEYWORDS="~amd64"
IUSE="pulseaudio"
RESTRICT="mirror strip"

DEPEND=""
RDEPEND="${DEPEND}
	pulseaudio? ( >=media-sound/pulseaudio-0.9.21 )
	|| ( dev-libs/libgcrypt:11/11 dev-libs/libgcrypt:0/11 )
	dev-libs/glib:2
	>=dev-libs/nspr-4.9
	dev-libs/nss
	gnome-base/gconf:2
	>=media-libs/alsa-lib-1.0.14
	sys-apps/dbus[X]
	x11-libs/gtk+:2
	x11-libs/libXScrnSaver"

S="${WORKDIR}"

QA_PREBUILT="usr/share/spotify/spotify
		usr/share/spotify/libcef.so
		usr/share/spotify/libffmpegsumo.so"

src_install() {
	rm -f usr/share/spotify/spotify.desktop
	dodoc usr/share/doc/spotify-client/changelog.Debian.gz

	SPOTIFY_HOME=/usr/share/spotify
	insinto ${SPOTIFY_HOME}
	doins -r usr/share/spotify/*
	fperms +x ${SPOTIFY_HOME}/spotify

	dodir /usr/bin
	cat <<-EOF >"${D}"/usr/bin/${MY_PN}
		#! /bin/sh
		exec ${SPOTIFY_HOME}/spotify "\$@"
	EOF
	fperms +x /usr/bin/spotify-client

	for size in 16 22 24 32 48 64 128 256; do
			newicon -s ${size} "${FILESDIR}/icons/spotify-linux-${size}.png" \
						"${MY_PN/-/_}.png"
							done

	make_desktop_entry "${MY_PN}" "Spotify Client (v${MY_PV})" "${MY_PN/-/_}"
	domenu "${S}${SPOTIFY_HOME}/${MY_PN}.desktop"
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
