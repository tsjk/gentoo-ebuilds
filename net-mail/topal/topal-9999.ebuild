EAPI=8

ADA_COMPAT=( gnat_2021 gcc_12 gcc_13 )
inherit ada flag-o-matic git-r3 toolchain-funcs

DESCRIPTION="Topal is a 'glue' program that links GnuPG and Pine/Alpine"
HOMEPAGE="http://homepage.ntlworld.com/phil.brooke/topal/"
EGIT_REPO_URI="https://dl.green-pike.co.uk/topal.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE="doc"

RDEPEND="${ADA_DEPS}
	app-crypt/gnupg
	|| ( app-text/dos2unix app-text/hd2u )
	mail-filter/procmail
	sys-libs/ncurses
	sys-libs/readline"
DEPEND="${RDEPEND}
	doc? ( app-text/texlive )"

src_prepare() {
	default
	sed -i -E '/^\tinstall .*-s --strip-program=/s/ -s --strip-program=\S* / /' Makefile
	use doc || {
		sed -i -e 's/^all:\tbinary topal\.pdf$/all:\tbinary/' Makefile
		sed -i -e '/\tinstall .* topal\.pdf /s/ topal\.pdf//' Makefile
	}
}

src_compile() {
	is-flagq -flto* && filter-flags -flto* -fuse-linker-plugin
	emake -j1 CC="$(tc-getCC)" CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}"
}

src_install() {
	emake install \
		INSTALLPATH="${D}"/usr \
		INSTALLPATHDOC="${D}/usr/share/doc/${PF}"
	use doc || rm "${D}/usr/share/doc/${PF}"/*.html
}
