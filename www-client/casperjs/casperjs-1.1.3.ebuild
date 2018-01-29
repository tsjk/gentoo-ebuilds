# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

MY_PV=${PV/_beta/-beta}
MY_PV=${MY_PV/_p/-}

DESCRIPTION="Navigation scripting & testing utility for PhantomJS and SlimerJS"
HOMEPAGE="http://casperjs.org/"
SRC_URI="https://github.com/casperjs/${PN}/archive/${MY_PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="mirror"

DEPEND=">=www-client/phantomjs-2.0.0"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-${MY_PV}"

src_compile() {
	:
}

src_test() {
	QT_QPA_PLATFORM="offscreen" emake || die "emake failed"
}

src_install() {
	insinto /usr/share/${P}/
	doins -r modules tests package.json

	insinto /usr/share/${P}/bin
	doins bin/bootstrap.js bin/usage.txt

	exeinto /usr/share/${P}/bin
	doexe bin/casperjs
	dosym ../share/${P}/bin/casperjs /usr/bin/casperjs

	dodoc CHANGELOG.md CONTRIBUTORS.md README.md
}
