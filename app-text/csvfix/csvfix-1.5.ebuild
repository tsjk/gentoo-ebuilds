# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/csvfix/csvfix-1.3.ebuild,v 1.1 2012/05/31 18:25:41 radhermit Exp $

EAPI="4"

inherit eutils flag-o-matic toolchain-funcs versionator

MY_PV="$(delete_all_version_separators)"
DESCRIPTION="A stream editor for manipulating CSV files"
HOMEPAGE="http://code.google.com/p/csvfix/"
SRC_URI="https://bitbucket.org/neilb/csvfix/get/version-1.5.tar.gz -> ${P}.tar.gz
	doc? ( http://csvfix.googlecode.com/files/csvfix_man_html_${MY_PV}0.zip )"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

RDEPEND="dev-libs/expat"
DEPEND="${RDEPEND}
	doc? ( app-arch/unzip )"

S="${WORKDIR}/neilb-csvfix-8ae6bdb5996e"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-1.3-make.patch
	epatch "${FILESDIR}"/${PN}-1.10a-tests.patch

	edos2unix $(find csvfix/tests -type f)
}

src_compile() {
	append-cflags "-std=c++0x"
	append-cxxflags "-std=c++0x"
	emake CC="$(tc-getCXX)" AR="$(tc-getAR)" lin
}

src_test() {
	cd ${PN}/tests
	chmod +x run1 runtests
	./runtests || die "tests failed"
}

src_install() {
	dobin csvfix/bin/csvfix
	use doc && dohtml -r "${WORKDIR}"/${PN}${MY_PV}/*
}
