EAPI=8

inherit toolchain-funcs

DESCRIPTION="Eric Raymond's hex dumper"
HOMEPAGE="http://www.catb.org/~esr/hexd/index.html"
SRC_URI="http://www.catb.org/~esr/hexd/${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="amd64 arm x86"
IUSE=""
RESTRICT="mirror"

src_prepare() {
	sed -i Makefile \
		-e "s|-O |${CFLAGS} ${LDFLAGS} |g" \
		|| die "sed on Makefile failed"
	tc-export CC
	eapply_user
}

src_install() {
	dobin ${PN}
	doman ${PN}.1
	dodoc NEWS README
}
