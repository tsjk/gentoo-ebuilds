EAPI=7

MY_PN="PRoot"

PYTHON_COMPAT=( python3_{6,7} )
inherit autotools eutils flag-o-matic git-r3 python-single-r1 toolchain-funcs

DESCRIPTION="User-space implementation of chroot, mount --bind, and binfmt_misc"
HOMEPAGE="https://proot-me.github.io/"
EGIT_REPO_URI="https://github.com/proot-me/${MY_PN}.git"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="care static test"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

LIB_DEPEND="
	care? ( app-arch/libarchive:0=[static-libs(+)] )
	dev-lang/python[static-libs(+)]
	dev-libs/libbsd[static-libs(+)]
	sys-libs/talloc[static-libs(+)]
"

RDEPEND="
!static? ( ${LIB_DEPEND//\[static-libs(+)]} )
"

DEPEND="
	${RDEPEND}
	app-doc/doxygen
        static? ( ${LIB_DEPEND} )
	care? ( dev-libs/uthash )
	test? ( dev-util/valgrind )
"

# test breaks sandbox
RESTRICT="
	!test? ( test )
"

PATCHES=(
		"${FILESDIR}/${PN}-lib-paths-fix.patch" \
		"${FILESDIR}/${PN}-makefile.patch" \
)

S="${WORKDIR}/${MY_PN,,}-${PV}"

src_prepare() {
	default
	use static && append-ldflags -static
}

src_compile() {
	# build the proot and care targets
	emake -C src \
		V=1 \
		CC="$(tc-getCC)" \
		CHECK_VERSION="true" \
		CAREBUILDENV="ok" \
		loader.elf loader-m32.elf build.h
	emake -C src \
		V=1 \
		CC="$(tc-getCC)" \
		CHECK_VERSION="true" \
		CAREBUILDENV="ok" \
		proot $(use care && echo "care")
	emake -C doc \
		V=1 \
		CC="$(tc-getCC)" \
		SUFFIX=".py"
}

src_install() {
	dobin src/proot
	newman doc/proot/man.1 proot.1
	dodoc HACKING.rst
	dodoc README.rst
	dodoc doc/proot/*.rst
	dodoc doc/security.rst
	if use care; then
		dobin src/care
		dodoc doc/care/*.rst
		insinto /usr/share/${P}
		doins -r contrib
	fi
}

src_test() {
	emake -C tests -j1 CC="$(tc-getCC)"
}


pkg_postinst() {
	elog "If you have segfaults on recent (>4.8) kernels"
	elog "try to disable seccomp support like so:"
	elog "'export PROOT_NO_SECCOMP=1'"
	elog "prior to running proot"

	if use care; then
		elog "You have enabled 'care' USE flag, that builds and installs"
		elog "dynamically linked care binary."
		elog "Upstream does NOT support such way of building CARE,"
		elog "it provides only prebuilt binaries."
		elog "CARE also has known problems on hardened systems"
		elog "Please do NOT file bugs about them to https://bugs.gentoo.org"
	fi
}
