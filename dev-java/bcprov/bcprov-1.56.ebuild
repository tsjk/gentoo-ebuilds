EAPI=8

JAVA_PKG_IUSE="doc source test"

inherit java-pkg-2 java-pkg-simple

MY_P="${PN}-jdk15on-${PV/./}"

DESCRIPTION="Java cryptography APIs"
HOMEPAGE="http://www.bouncycastle.org/java.html"
SRC_URI="http://www.bouncycastle.org/download/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="1.56"
KEYWORDS="~amd64 ~ppc64 ~x86 ~amd64-fbsd ~x86-fbsd ~amd64-linux ~x86-linux ~x64-macos"

DEPEND=">=virtual/jdk-1.7
	app-arch/unzip"

RDEPEND=">=virtual/jre-1.7"

S="${WORKDIR}/${MY_P}"

JAVA_ENCODING="ISO-8859-1"

# Package can't be build with test as bcprov and bcpkix can't be built with test.
RESTRICT="test"

src_unpack() {
	default
	cd "${S}" || die
	unpack ./src.zip
}

src_prepare() {
	if ! use test; then
		# There are too many files to delete so we won't be using JAVA_RM_FILES
		# (it produces a lot of output).
		local RM_TEST_FILES=()
		while read -d $'\0' -r file; do
			RM_TEST_FILES+=("${file}")
		done < <(find . -name "*Test*.java" -type f -print0)
		while read -d $'\0' -r file; do
			RM_TEST_FILES+=("${file}")
		done < <(find . -name "*Mock*.java" -type f -print0)

		rm -v "${RM_TEST_FILES[@]}" || die
	fi
	default
}

src_compile() {
	java-pkg-simple_src_compile
}

src_install() {
	java-pkg-simple_src_install
	use source && java-pkg_dosrc org
}
