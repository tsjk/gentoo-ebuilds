# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-pkg-simple

DESCRIPTION="Mantissa (Mathematical Algorithms for Numerical Tasks In Space System Applications)"
HOMEPAGE="http://www.spaceroots.org/software/mantissa/index.html"
SRC_URI="http://www.spaceroots.org/software/mantissa/mantissa-7.2-src.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	${CDEPEND}
	>=virtual/jre-1.6"

DEPEND="
	${CDEPEND}
	>=virtual/jdk-1.6"

S="${WORKDIR}/${P}-src"

src_prepare() {
	default
	rm -rv "${S}/tests-src" || die
}
