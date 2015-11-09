# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python{2_7,3_3,3_4,3_5} )

CMAKE_MAKEFILE_GENERATOR=ninja

EGIT_REPO_URI="https://github.com/baruch/diskscan.git"

inherit cmake-utils git-r3 python-single-r1

DESCRIPTION="Scan disk for bad or near failure sectors, performs disk diagnostics"
HOMEPAGE="http://blog.disksurvey.org/proj/diskscan/"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-util/ctags
	dev-util/ninja
	sys-libs/libtermcap-compat
	sys-libs/ncurses[unicode]
	sys-libs/zlib"
RDEPEND="${DEPEND}"

DOCS=( DEVELOP.md README.md )

