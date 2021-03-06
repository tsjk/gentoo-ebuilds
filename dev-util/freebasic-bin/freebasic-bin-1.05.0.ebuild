# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit eutils

DESCRIPTION="A free/open source (GPL), BASIC compiler for Microsoft Windows, DOS and Linux."
HOMEPAGE="http://www.freebasic.net/"

SRC_URI="x86? ( http://sourceforge.net/projects/fbc/files/Binaries%20-%20Linux/FreeBASIC-${PV}-linux-x86.tar.gz )
	amd64? ( http://sourceforge.net/projects/fbc/files/Binaries%20-%20Linux/FreeBASIC-${PV}-linux-x86_64.tar.gz )"

KEYWORDS="~amd64 ~x86"
IUSE=""
LICENSE="GFDL"
RESTRICT="mirror"
SLOT="0"

DEPEND="media-libs/mesa
	sys-devel/binutils
	sys-devel/gcc
	sys-libs/gpm
	sys-libs/ncurses
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXpm
	x11-libs/libXrandr
	virtual/libffi
	"

RDEPEND="${DEPEND}"

src_unpack() {
	default
	if use amd64; then
		S="${WORKDIR}/FreeBASIC-${PV}-linux-x86_64"
	elif use x86; then
		S="${WORKDIR}/FreeBASIC-${PV}-linux-x86"
	fi
}

src_install() {
	dodir "/usr" || die
	./install.sh -i "${D}/usr" || die
	mv "${D}"/usr/bin/fbc{,.real}
	make_wrapper "fbc" "/usr/bin/fbc.real -prefix /usr"
	dodir "/usr/share" || die
	mv "${D}/usr/man" "${D}/usr/share/" || die
}
