# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="An IRC bot extensible with C or TCL"
HOMEPAGE="https://www.eggheads.org/"
SRC_URI="https://ftp.eggheads.org/pub/eggdrop/source/${PV:0:3}/${P}.tar.gz"

KEYWORDS="~alpha ~amd64 ~ia64 ~mips ~ppc ~sparc ~x86"
LICENSE="GPL-2"
SLOT="0"
IUSE="debug ipv6 ssl static"

DEPEND="
	dev-lang/tcl:0
	ssl? ( dev-libs/openssl:0= )
"
RDEPEND="
	sys-apps/gentoo-functions
	${DEPEND}
"

# See bug #533490
MAKEOPTS+=" -j1"

src_prepare()  {
	# fix bug #335230
	sed -i \
		-e '/\$(LD)/s/-o/$(CFLAGS) $(LDFLAGS) &/' \
		src/mod/*.mod/Makefile* src/Makefile.in || die
	default
}

src_configure() {
	econf $(use_enable ssl tls) \
		$(use_enable ipv6 ipv6)

	emake config
}

src_compile() {
	local target=""

	if use static && use debug; then
		target="sdebug"
	elif use static; then
		target="static"
	elif use debug; then
		target="debug"
	fi

	emake ${target} || die
}

src_install() {
	local a b
	emake DEST="${D}"/opt/eggdrop install

	for a in doc/*; do
		[ -f ${a} ] && dodoc ${a}
	done

	dodoc text/motd.*

	dodoc -r doc/html

	dobin "${FILESDIR}"/eggdrop-installer
	doman doc/man1/eggdrop.1
}

pkg_postinst() {
	elog "Please run /usr/bin/eggdrop-installer to install your eggdrop bot."
}
