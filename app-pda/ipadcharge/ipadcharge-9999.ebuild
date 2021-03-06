# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit autotools git-r3 eutils flag-o-matic

DESCRIPTION="Enables USB charging for Apple devices."
HOMEPAGE="https://github.com/mkorenkov/ipad_charge"
EGIT_REPO_URI="git://github.com/mkorenkov/ipad_charge.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="dev-libs/libusb:1"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${P}"

src_prepare() {
	#sed -i 's|\/usr|\$\{DESTDIR\}\/usr|g' Makefile
	#sed -i 's|\/etc|\$\{DESTDIR\}\/etc|g' Makefile
	( cd "${S}" && epatch "${FILESDIR}/${PN}-9999-makefile.patch" )
}
