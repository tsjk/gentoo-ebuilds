# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit autotools autotools-utils git-r3 eutils flag-o-matic

DESCRIPTION="f2c (FORTRAN to C converter) and libi77/libi77 (library that converts FORTRAN to C source) all together in an autoconf package."
HOMEPAGE="https://github.com/juanjosegarciaripoll/f2c"
EGIT_REPO_URI="git://github.com/juanjosegarciaripoll/f2c.git"

LICENSE="HPND"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
	app-arch/unzip"

src_prepare() {
	eautoreconf
}

src_install() {
	autotools-utils_src_install
	mv doc/f2c.1 doc/f2c.1.txt
	mv doc/f2c.1t doc/f2c.1
	doman doc/f2c.1
}
