EAPI=8

inherit edos2unix toolchain-funcs vcs-snapshot

MY_PV="$(ver_rs 1- '')"
DESCRIPTION="A stream editor for manipulating CSV files"
HOMEPAGE="https://csvfix.sourceforge.io/"
SRC_URI="https://downloads.sourceforge.net/project/csvfix/${P}.tar.bz2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-libs/expat"
DEPEND="${RDEPEND}"

PATCHES=(
	"${FILESDIR}"/${P}-makefile.patch
	"${FILESDIR}"/${PN}-1.10a-tests.patch
	"${FILESDIR}"/${P}-shuffle-test.patch
)

src_prepare() {
	default
	edos2unix $(find csvfix/tests -type f)
}

src_compile() {
	emake CC="$(tc-getCXX)" AR="$(tc-getAR)" lin
}

src_test() {
	cd ${PN}/tests
	chmod +x run1 runtests
	./runtests || die "tests failed"
}

src_install() {
	dobin csvfix/bin/csvfix
}
