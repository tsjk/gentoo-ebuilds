EAPI=8

inherit java-pkg-2 java-pkg-simple

DESCRIPTION="Mantissa (Mathematical Algorithms for Numerical Tasks In Space System Applications)"
HOMEPAGE="https://wiki.gentoo.org/wiki/No_homepage"
SRC_URI="https://ipfs.io/ipfs/Qmegc8L7UhddsDJb3JQZs2xoNu18VjhUC5ifp29KTSzsEb -> ${P}-src.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	${CDEPEND}
	>=virtual/jre-1.6"

DEPEND="
	${CDEPEND}
	>=virtual/jdk-1.6"

S="${WORKDIR}/${P}-src"

src_prepare() {
	default
	rm -rv "${S}/tests-src" || die
}
