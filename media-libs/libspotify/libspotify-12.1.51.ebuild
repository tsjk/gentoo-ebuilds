# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit eutils

DESCRIPTION="libspotify C API"
HOMEPAGE="http://developer.spotify.com/en/libspotify/"
SRC_URI="
	x86? (
	http://developer.spotify.com/download/libspotify/${P}-Linux-i686-release.tar.gz ) 
	amd64? (
	http://developer.spotify.com/download/libspotify/${P}-Linux-x86_64-release.tar.gz )"
LICENSE="Spotify"
SLOT=0
KEYWORDS="~amd64 ~x86"
IUSE="doc"
RESTRICT="strip"

src_unpack() {
	unpack ${A}
	use amd64 && S=${WORKDIR}/${P}-Linux-x86_64-release
	use x86 && S=${WORKDIR}/${P}-Linux-i686-release
}

src_configure() {
	sed -i 's/\$(prefix)/\${DESTDIR}\$(prefix)/g' Makefile
	sed -i '/^\tldconfig/{N;d;}' Makefile
}

src_compile() {
	einfo "Nothing to compile"
}

src_install() {
	emake DESTDIR="${D}" prefix=/usr install || die "emake install failed"
        sed -e 's/PKG_PREFIX/\/usr/g' < lib/pkgconfig/libspotify.pc > "${D}/usr/lib/pkgconfig/libspotify.pc"
	use doc && dodoc ChangeLog LICENSE README licenses.xhtml
}
