EAPI=8

inherit autotools toolchain-funcs

MY_PV=$(ver_cut 1-2)
DEB_PV=${MY_PV}-$(ver_cut 3)

DESCRIPTION="Metamail (with Debian patches) - Generic MIME package"
HOMEPAGE="http://ftp.funet.fi/pub/unix/mail/metamail/"
SRC_URI="http://ftp.funet.fi/pub/unix/mail/metamail/mm${MY_PV}.tar.Z
	https://ipfs.io/ipfs/QmQ8aE9bUkH5YL7n6KnedFRLe2QqvE8777WH2yxz5Z9hwJ -> metamail_${DEB_PV}.diff.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sparc ~x86"
IUSE="static-libs"

DEPEND="app-arch/sharutils
	net-mail/mailbase
	sys-libs/ncurses:="
RDEPEND="
	${DEPEND}
	app-misc/mime-types
	sys-apps/debianutils"
BDEPEND="virtual/pkgconfig"

S="${WORKDIR}/mm${MY_PV}/src"

src_prepare() {
	eapply "${WORKDIR}"/metamail_${DEB_PV}.diff
	eapply "${FILESDIR}"/${PN}-2.7.45.3-CVE-2006-0709.patch
	eapply "${FILESDIR}"/${P}-glibc-2.10.patch

	# respect CFLAGS
	sed -i -e 's/CFLAGS/LIBS/' \
		"${S}"/src/{metamail,richmail}/Makefile.am || die

	# add missing include - QA
	sed -i -e '/^#include <config\.h>$/a #include <string.h>' \
		"${S}"/src/metamail/shared.c || die

	# Fix building with ncurses[tinfo]
	sed -i -e "s/-lncurses/$($(tc-getPKG_CONFIG) --libs ncurses)/" \
		"${S}"/src/richmail/Makefile.am \
		"${S}"/src/metamail/Makefile.am || die

	eapply_user
	eautoreconf
	chmod +x "${S}"/configure
}

src_configure() {
	econf $(use_enable static-libs static)
}

src_compile() {
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS}"
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc CREDITS README
	rm man/mmencode.1
	rm man/mailcap.5
	doman man/* debian/mimencode.1 debian/mimeit.1

	use static-libs || find "${D}"/usr/lib* -name '*.la' -delete
}
