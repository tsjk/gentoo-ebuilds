EAPI=8
inherit git-r3

DESCRIPTION="Lightweight HTTP server for static content"
HOMEPAGE="http://linux.bytesex.org/misc/webfs.html"
EGIT_REPO_URI="https://github.com/fserb/webfsd.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="libressl ssl threads"

DEPEND="
	ssl? ( dev-libs/openssl:0= )"

RDEPEND="${DEPEND}
	app-misc/mime-types"

PATCHES=(
	"${FILESDIR}/${PN}-1.21-Variables.mk-dont-strip-binaries-on-install.patch"
	"${FILESDIR}/${PN}-1.21-CVE-2013-0347.patch" )

src_prepare() {
	default
	sed -e "s:/etc/mime.types:${EPREFIX}\\0:" -i GNUmakefile || die "sed failed"
}

src_compile() {
	local myconf
	use ssl || myconf="${myconf} USE_SSL=no"
	use threads && myconf="${myconf} USE_THREADS=yes"

	emake prefix="${EPREFIX}/usr" ${myconf}
}

src_install() {
	local myconf
	use ssl || myconf="${myconf} USE_SSL=no"
	use threads && myconf="${myconf} USE_THREADS=yes"
	emake install ${myconf} prefix="${EPREFIX}/usr" mandir="${ED}/usr/share/man" DESTDIR="${D}"
	newinitd "${FILESDIR}"/${PN}.initd-r1 ${PN}
	newconfd "${FILESDIR}"/${PN}.confd ${PN}
	dodoc INSTALL
	dodoc README.md
}

pkg_preinst() {
	# Fix existing log permissions for bug #458892.
	chmod 0600 "${EROOT}/var/log/webfsd.log" 2>/dev/null
}
