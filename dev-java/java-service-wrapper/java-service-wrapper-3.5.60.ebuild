# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

JAVA_PKG_IUSE="doc source test"
JAVA_TESTING_FRAMEWORKS="junit-4"

inherit flag-o-matic java-pkg-2 java-pkg-simple toolchain-funcs

DESCRIPTION="A wrapper that makes it possible to install a Java Application as daemon"
HOMEPAGE="https://wrapper.tanukisoftware.com"
SRC_URI="https://download.tanukisoftware.com/wrapper/${PV}/wrapper_${PV}_src.tar.gz"
S="${WORKDIR}/wrapper_${PV}_src"

LICENSE="tanuki-community"
SLOT="0"
KEYWORDS="amd64 ~arm64"
RESTRICT="!test? ( test )"

RDEPEND=">=virtual/jre-1.8:*"
DEPEND="
	>=virtual/jdk-11:*
	test? (
		dev-java/junit:4
		dev-util/cunit
	)
"
BDEPEND=">=dev-java/ant-1.10.14-r3:0"

JAVA_SRC_DIR="src/java/org/tanukisoftware"
JAVA_TEST_SRC_DIR="src/test"
JAVA_TEST_GENTOO_CLASSPATH="junit-4"

PATCHES=(
	"${FILESDIR}"/java-service-wrapper-3.5.60-gentoo-wrapper-defaults.patch
)

src_prepare() {
	default #780585

	# replaces as-needed.patch
	sed -i \
		-e 's/gcc -O3/$(CC)/g' \
		-e 's/ -pthread/ $(CFLAGS) $(LDFLAGS) -pthread/g' \
		-e 's/ -shared/ $(LDFLAGS) -shared/g' \
		-e 's/$(TEST)\/testsuite/testsuite/g' \
		src/c/Makefile-*.make || die

	cp "${S}/src/c/Makefile-linux-armel-32.make" "${S}/src/c/Makefile-linux-arm-32.make"
	java-pkg-2_src_prepare

	# disable tests by default (they are only enabled by default on amd64)
	sed -e "s/\(all: init wrapper libwrapper.so\) testsuite/\1/g" \
		-i src/c/Makefile-linux-x86-64.make || die

	# re-enable tests on all platforms if requested
	if use test; then
		grep "testsuite_SOURCE" "src/c/Makefile-linux-x86-64.make" | tee -a src/c/Makefile-*.make
		assert
		echo 'all: testsuite' | tee -a src/c/Makefile-*.make
		assert
	fi

	sed -e '/deprecation=/s/"on"/"off"/' -i "${S}/build.xml" || die

}

src_compile() {
	tc-export CC
	append-cflags -Wno-discarded-qualifiers

	pushd "${T}" || die
	echo 'public class GetArchDataModel{public static void main(String[] args){System.out.println(System.getProperty("sun.arch.data.model"));}}' \
		> GetArchDataModel.java || die
	ejavac GetArchDataModel.java
	local BITS
	BITS="$(java GetArchDataModel)" || die "Failed to identify sun.arch.data.model property"
	popd || die

	eant -Dfile.encoding=UTF-8 -Djavac.target.version=8 -Dbits="${BITS}" compile-c-unix

	JAVA_JAR_FILENAME="org.tanukisoftware.wrapper.jar"
	java-pkg-simple_src_compile
	jdeps --generate-module-info \
		"${JAVA_SRC_DIR}" \
		--multi-release 9 \
		"${JAVA_JAR_FILENAME}" || die

	JAVA_JAR_FILENAME="wrapper.jar"
	java-pkg-simple_src_compile
}

src_test() {
	src/c/testsuite --basic || die
	java-pkg-simple_src_test
}

src_install() {
	java-pkg-simple_src_install
	java-pkg_doso lib/libwrapper.so

	dobin bin/wrapper
	dodoc README*.txt
	dodoc doc/revisions.txt
}
