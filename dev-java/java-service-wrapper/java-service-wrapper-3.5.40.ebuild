# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=5
JAVA_PKG_IUSE="doc source test"

inherit eutils java-pkg-2 java-ant-2

MY_PN="wrapper"
MY_P="${MY_PN}_${PV}_src"
DESCRIPTION="A wrapper that makes it possible to install a Java Application as daemon"
HOMEPAGE="http://wrapper.tanukisoftware.org/"
SRC_URI="http://${MY_PN}.tanukisoftware.org/download/${PV}/${MY_P}.tar.gz"

LICENSE="tanuki-community"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="
	>=virtual/jre-1.4"
DEPEND="
	>=virtual/jdk-1.4
	test? (
		dev-java/ant-junit:0
	)"

S="${WORKDIR}/${MY_P}"

JAVA_ANT_REWRITE_CLASSPATH="true"

# ebuild java-service-wrapper-3.5.40-r1.ebuild digest clean unpack && pushd /tmp/portage/dev-java/java-service-wrapper-3.5.40/work/wrapper_3.5.40_src && \
# ( cd src/c && ls -1 Makefile-linux-* | xargs -d '\n' -r -n 1 -I[] cp -av [] [].orig ) && \
# ( cd src/c && ls -1 Makefile-linux-*.make | xargs -d '\n' -r -n 1 sed -i '\@$(COMPILE) .* -lm .*@s@$(COMPILE) @$(COMPILE) $(CFLAGS) $(LDFLAGS) @' ) && \
# ( cd src/c && ls -1 Makefile-linux-*.make | xargs -d '\n' -r -n 1 sed -i '\@${COMPILE} .*-shared .*@s@${COMPILE} .*-shared @${COMPILE} $(LDFLAGS) -shared @' ) && \
# ( cd src/c && ls -1 Makefile-linux-*.make | xargs -d '\n' -r -n 1 sed -i '\@$(COMPILE) .*-c @s@$(COMPILE) @$(COMPILE) $(CFLAGS) @' ) && \
# find . -name 'Makefile-linux-*.orig' -exec bash -c 'diff -ub "${1}" "${1%\.orig}"' _ {} \; > /usr/local/portage/dev-java/java-service-wrapper/files/java-service-wrapper-3.5.40-as-needed.patch && \
# popd

PATCHES=(
	"${FILESDIR}"/${P}-as-needed.patch
	"${FILESDIR}"/${P}-gentoo-wrapper-defaults.patch
	"${FILESDIR}"/${P}-testsuite.patch
)

java_prepare() {
	epatch "${PATCHES[@]}"

	cp "${S}/src/c/Makefile-linux-armel-32.make" "${S}/src/c/Makefile-linux-arm-32.make"
}

src_compile() {
	tc-export CC
	BITS="32"
	use amd64 && BITS="64"
	eant -Dbits=${BITS} jar compile-c
	if use doc; then
		ejavadoc -d api -sourcepath src/java/ -subpackages org \
			|| die "javadoc	failed"
	fi
}

src_test() {
	ANT_TASKS="ant-junit" eant -Dbits="${BITS}" test
}

src_install() {
	java-pkg_dojar lib/wrapper.jar
	java-pkg_doso lib/libwrapper.so

	dobin bin/wrapper
	dodoc README*.txt || die
	dodoc doc/revisions.txt || die

	use doc && java-pkg_dojavadoc api
	use source && java-pkg_dosrc src/java/*
}
