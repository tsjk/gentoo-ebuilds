EAPI=8

LUA_COMPAT=( lua5-{3,4} )

inherit flag-o-matic lua-single

DESCRIPTION="bozohttpd is a small and secure http server"
HOMEPAGE="http://www.eterna.com.au/bozohttpd/"
SRC_URI="http://www.eterna.com.au/bozohttpd/${P}.tar.bz2"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="+htpasswd lua +ssl"
RESTRICT="mirror"

REQUIRED_USE="lua? ( ${LUA_REQUIRED_USE} )"
DEPEND="
	lua? ( ${LUA_DEPS} )
	htpasswd? ( virtual/libcrypt )
	ssl? ( dev-libs/openssl:0= )"
BDEPEND="
	virtual/pkgconfig"
RDEPEND="
	${DEPEND}
	virtual/logger"

PATCHES=( "${FILESDIR}/include_stdint_h.patch" )

pkg_setup() {
	use lua && lua-single_pkg_setup
}

src_prepare() {
	default
	mv Makefile{.boot,} || die
}

src_compile() {
	append-cppflags -D_GNU_SOURCE -D_DEFAULT_SOURCE -DNO_BLOCKLIST_SUPPORT
	append-ldflags $(no-as-needed)
	local CRYPTOLIBS
	if use htpasswd; then
		CRYPTOLIBS+=" -lcrypt"
		append-cppflags -DDO_HTPASSWD
	fi
	if use lua; then
		append-cflags $(lua_get_CFLAGS)
		append-libs $(lua_get_LIBS)
	else
		append-cppflags -DNO_LUA_SUPPORT
	fi
	if use ssl; then
		CRYPTOLIBS+=" -lcrypto -lssl"
	else
		append-cppflags -DNO_SSL_SUPPORT
	fi
	emake V=1 CC="$(tc-getCC)" OPT="${CFLAGS}" LARGE_CFLAGS="" LOCAL_CFLAGS="" \
		CPPFLAGS="${CPPFLAGS}" CRYPTOLIBS="${CRYPTOLIBS}" EXTRALIBS="${LIBS}" \
		LDFLAGS="${LDFLAGS}" || die "emake failed!"
}

src_install() {
	dobin bozohttpd
	doman bozohttpd.8
	dodoc CHANGES

	newconfd "${FILESDIR}"/${PN}.conffile   bozohttpd
	newinitd "${FILESDIR}"/${PN}.initscript bozohttpd

	if use lua; then
		exeinto /usr/lib/${PN}/cgi-bin
		doexe *.lua
	fi

	insinto /usr/share/${PN}
	doins testsuite/*.*
	doins testsuite/data/*.*
}
