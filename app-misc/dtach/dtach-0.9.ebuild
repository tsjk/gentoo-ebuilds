# $Id$

EAPI=6

inherit eutils

DESCRIPTION="Emulates the detach feature of screen"
HOMEPAGE="http://dtach.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~arm ~ppc ~x86"
IUSE=""
RESTRICT="mirror"

src_install() {
	dobin dtach
	doman dtach.1
	dodoc README
}
