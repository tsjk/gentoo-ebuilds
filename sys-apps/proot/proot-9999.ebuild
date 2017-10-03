EAPI=6
MY_PN="PRoot"

inherit autotools eutils git-r3 toolchain-funcs

DESCRIPTION="User-space implementation of chroot, mount --bind, and binfmt_misc"
HOMEPAGE="https://proot-me.github.io/"
EGIT_REPO_URI="https://github.com/proot-me/${MY_PN}.git"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="care test"

RDEPEND="care? ( app-arch/libarchive:0= )
	 sys-libs/talloc"
DEPEND="${RDEPEND}
	care? ( dev-libs/uthash )
	test? ( dev-util/valgrind )"

# Breaks sandbox
RESTRICT="test"

PATCHES=(	"${FILESDIR}/${PN}-makefile.patch" \
		"${FILESDIR}/${PN}-lib-paths-fix.patch" )

S="${WORKDIR}/${MY_PN,,}-${PV}"

src_compile() {
	# build the proot and care targets
	emake -C src V=1 \
		CC="$(tc-getCC)" \
		CHECK_VERSION="true" \
		CAREBUILDENV="ok" \
		proot $(use care && echo "care")
}

src_install() {
	if use care; then
		dobin src/care
		dodoc doc/care/*.txt
	fi
	dobin src/proot
	newman doc/proot/man.1 proot.1
	dodoc doc/proot/*.txt
	dodoc -r doc/articles
}

src_test() {
	emake -C tests -j1 CC="$(tc-getCC)"
}

pkg_postinst() {
	if use care; then
		elog "You have enabled 'care' USE flag, that builds and installs"
		elog "dynamically linked care binary."
		elog "Upstream does NOT support such way of building CARE,"
		elog "it provides only prebuilt binaries."
		elog "CARE also has known problems on hardened systems"
		elog "Please do NOT file bugs about them to https://bugs.gentoo.org"
	fi
}