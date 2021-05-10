EAPI=7

inherit toolchain-funcs

DESCRIPTION="A shell-level interface to TCP sockets"
HOMEPAGE="http://www.jnickelsen.de/socket/"
SRC_URI="http://w21.org/jnickelsen/${PN}/${P/_/}.tar.gz"
LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux"
RESTRICT="mirror"

IUSE="examples"

PATCHES=( "${FILESDIR}/${P}-makefile.patch" )

S="${WORKDIR}/${P/_/}"

src_compile() {
	emake CC="$(tc-getCC)"
}

src_install() {
	dobin socket
	doman socket.1
	dodoc BLURB CHANGES README
	if use examples; then
		docinto examples
		dodoc scripts/*
	fi
}
