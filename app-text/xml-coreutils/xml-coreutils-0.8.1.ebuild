EAPI=8

inherit autotools flag-o-matic multilib toolchain-funcs

DESCRIPTION="The aim of xml-coreutils is to retrofit a natural XML processing capability on existing shells, which can coexist and interact seamlessly with the classical tools."
HOMEPAGE="http://xml-coreutils.sourceforge.net/"
SRC_URI="http://www.lbreyer.com/gpl/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="mirror"

RDEPEND="dev-libs/expat
	 sys-libs/ncurses
	 sys-libs/slang
"

DEPEND="${RDEPEND}
	sys-devel/flex
"

src_configure() {
	append-cflags "-std=gnu99"
	default
}
