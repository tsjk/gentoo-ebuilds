EAPI=8

inherit git-r3

DESCRIPTION="Emulates the detach feature of screen"
HOMEPAGE="http://dtach.sourceforge.net/"
EGIT_REPO_URI="https://github.com/crigler/dtach.git"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS=""
IUSE=""

src_install() {
	dobin dtach
	doman dtach.1
	dodoc README
}
