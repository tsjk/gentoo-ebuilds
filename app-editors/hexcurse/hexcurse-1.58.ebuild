# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:

EAPI=5
inherit autotools eutils

DESCRIPTION="ncurses based hex editor"
HOMEPAGE="http://www.jewfish.net/description.php?title=HexCurse"
SRC_URI="https://github.com/LonnyGomes/hexcurse/archive/${P}.tar.gz"
RESTRICT="mirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ppc s390 sh sparc x86 ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos"

RDEPEND=">=sys-libs/ncurses-5.2"
DEPEND="
	${RDEPEND}
	virtual/pkgconfig
"

S="${WORKDIR}/hexcurse-${P}"

src_prepare() {
	epatch "${FILESDIR}"/${PV}-tinfo.patch
	eautoreconf
}

src_install() {
	emake install DESTDIR="${D}" || die "Install failed"
	dodoc AUTHORS ChangeLog NEWS README
}
