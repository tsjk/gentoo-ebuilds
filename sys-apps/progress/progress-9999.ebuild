EAPI=7
inherit git-r3 toolchain-funcs

DESCRIPTION="Coreutils Viewer: show progress for cp, rm, dd, and so forth"
HOMEPAGE="https://github.com/Xfennec/progress"
EGIT_REPO_URI="https://github.com/Xfennec/progress.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""

RDEPEND="sys-libs/ncurses"
DEPEND="
	${RDEPEND}
	virtual/pkgconfig
"

src_prepare() {
	default
	sed -i \
		-e '/LDFLAGS/s:-lncurses:$(shell $(PKG_CONFIG) --libs ncurses):' \
		-e 's:CFLAGS=-g:CFLAGS+=:' \
		-e 's:gcc:$(CC):g' \
		Makefile || die
	tc-export CC PKG_CONFIG
}

src_install() {
	emake PREFIX="${D}/${EPREFIX}/usr" install
	dodoc README.md
}
