# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit toolchain-funcs

DESCRIPTION="bozohttpd is a small and secure http server"
HOMEPAGE="http://www.eterna.com.au/bozohttpd/"
SRC_URI="http://www.eterna.com.au/bozohttpd/${P}.tar.bz2"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="libressl lua"

DEPEND="lua? ( dev-lang/lua:= )
	!libressl? ( dev-libs/openssl:0= )
	libressl? ( dev-libs/libressl:= )"
RDEPEND="${DEPEND}
	virtual/logger"

PATCHES=( "${FILESDIR}/netbsd_patches.patch"
	  "${FILESDIR}/includes_fix.patch"
	  "${FILESDIR}/link_fix.patch" )

src_prepare() {
	default
	mv Makefile{.boot,} || die
	sed -i 's/d_namlen/d_reclen/g' "${S}/bozohttpd.c" || die
}

src_compile() {
	if use lua; then
		emake CC="$(tc-getCC)" OPT="${CFLAGS}" LARGE_CFLAGS="" LOCAL_CFLAGS="" CPPFLAGS="-D_GNU_SOURCE -D__USE_XOPEN -DDO_HTPASSWD" LDFLAGS="-llua"
	else
		emake CC="$(tc-getCC)" OPT="${CFLAGS}" LARGE_CFLAGS="" LOCAL_CFLAGS="" CPPFLAGS="-D_GNU_SOURCE -D__USE_XOPEN -DDO_HTPASSWD"
	fi
}

src_install() {
	dobin bozohttpd
	doman bozohttpd.8

	newconfd "${FILESDIR}"/${PN}.conffile   bozohttpd
	newinitd "${FILESDIR}"/${PN}.initscript bozohttpd
}
