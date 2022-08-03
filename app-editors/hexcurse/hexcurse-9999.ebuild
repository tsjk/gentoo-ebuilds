EAPI=8
inherit autotools git-r3

DESCRIPTION="ncurses based hex editor"
HOMEPAGE="http://www.jewfish.net/description.php?title=HexCurse"
EGIT_REPO_URI="https://github.com/prso/hexcurse.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""

RDEPEND=">=sys-libs/ncurses-6.2"
DEPEND="
	${RDEPEND}
	virtual/pkgconfig
"

PATCHES=( "${FILESDIR}"/${PV}-tinfo.patch )

S="${WORKDIR}/${P}"

src_prepare() {
	default
	eautoreconf
}

src_install() {
	emake install DESTDIR="${D}" || die "Install failed"
	dodoc AUTHORS ChangeLog NEWS README
}
