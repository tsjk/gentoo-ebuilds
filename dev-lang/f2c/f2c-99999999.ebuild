EAPI=8

inherit autotools flag-o-matic git-r3

DESCRIPTION="f2c (FORTRAN to C converter) and libi77/libi77 (library that converts FORTRAN to C source) all together in an autoconf package."
HOMEPAGE="https://github.com/juanjosegarciaripoll/f2c"
EGIT_REPO_URI="https://github.com/juanjosegarciaripoll/f2c.git"

LICENSE="HPND"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
	app-arch/unzip"

src_prepare() {
	eapply_user
	eautoreconf
}

src_configure() {
	append-cflags -std=gnu89
	default
}

src_install() {
	mv doc/f2c.1 doc/f2c.1.txt
	mv doc/f2c.1t doc/f2c.1
	doman doc/f2c.1
	default
}
