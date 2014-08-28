# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit autotools

IUSE="aalib alsa dv lirc mmx motif opengl quicktime X xft xv zvbi xext"

DESCRIPTION="Small suite of video4linux related software"
HOMEPAGE="http://linuxtv.org/projects.php"
SRC_URI="http://linuxtv.org/downloads/${PN}/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"

RDEPEND=">=sys-libs/ncurses-5.1
		virtual/jpeg
		X? (
			x11-libs/libXmu
			x11-libs/libX11
			x11-libs/libXaw
			x11-libs/libXpm
			x11-libs/libXt
			x11-libs/libXext
			xext? (
				x11-libs/libXrandr
				x11-libs/libXrender
				x11-libs/libXinerama
				x11-libs/libXxf86dga
				x11-libs/libXrandr
				x11-libs/libXxf86vm
			)
			xv? ( x11-libs/libXv )
		)
		motif? (
			>=x11-libs/motif-2.3:0
			)
	alsa? ( media-libs/alsa-lib )
	aalib? ( media-libs/aalib )
	dv? ( media-libs/libdv )
	lirc? ( app-misc/lirc )
	opengl? ( virtual/opengl )
	quicktime? ( media-libs/libquicktime )
	zvbi? (
		media-libs/zvbi
		media-libs/libpng
		)"

DEPEND="${RDEPEND}"

src_configure() {
	econf \
		$(use_with X x) \
		$(use_enable xft) \
		$(use_enable xext xfree-ext) \
		$(use_enable xv xvideo) \
		$(use_enable dv)  \
		$(use_enable mmx) \
		$(use_enable motif) \
		$(use_enable quicktime) \
		$(use_enable alsa) \
		$(use_enable lirc) \
		$(use_enable opengl gl) \
		$(use_enable zvbi) \
		$(use_enable aalib aa)
}

src_compile() {
	emake verbose=yes
}

src_install() {
	emake install DESTDIR="${D}" resdir="${D}"/etc/X11

	# v4lctl is only installed automatically if the X USE flag is enabled
	use X || \
		dobin x11/v4lctl

	dodoc Changes README* TODO "${FILESDIR}"/webcamrc
	docinto cgi-bin
	dodoc scripts/webcam.cgi

	use X || \
		rm -f "${D}"/usr/share/man/man1/{pia,propwatch}.1 \
			"${D}"/usr/share/{man,man/fr,man/es}/man1/xawtv.1 \
			"${D}"/usr/share/{man,man/es}/man1/rootv.1

	use motif || \
		rm -f "${D}"/usr/share/man/man1/{motv,mtt}.1

	use zvbi || \
		rm -f "${D}"/usr/share/man/man1/{alevtd,mtt}.1 \
			"${D}"/usr/share/{man,man/es}/man1/scantv.1
}
