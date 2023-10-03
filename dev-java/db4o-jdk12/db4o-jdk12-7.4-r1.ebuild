EAPI=8

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-pkg-simple

DESCRIPTION="Core files for the object database for Java"
HOMEPAGE="https://wiki.gentoo.org/wiki/No_homepage"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

CDEPEND="dev-java/db4o-jdk11:0"

RDEPEND="
	${CDEPEND}
	>=virtual/jre-1.6"

DEPEND="
	${CDEPEND}
	>=virtual/jdk-1.6"

S="${WORKDIR}/${P}"

JAVA_GENTOO_CLASSPATH="db4o-jdk11"

src_prepare() {
	default
	rm -rv "${S}/test" || die
}
