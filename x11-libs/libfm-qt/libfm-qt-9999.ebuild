# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

EGIT_REPO_URI="https://github.com/lxde/${PN}"
inherit cmake-utils git-r3

DESCRIPTION="Qt port of libfm, a library providing components to build desktop file managers"
HOMEPAGE="http://pcmanfm.sourceforge.net/"

IUSE="doc"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""

COMMON_DEPEND="	>=dev-qt/linguist-tools-5.2
		>=dev-qt/qtwidgets-5.2
		>=dev-qt/qtx11extras-5.2
		>=lxde-base/menu-cache-0.4
		>=x11-libs/libfm-1.2
		doc? ( app-doc/doxygen )"
RDEPEND="${COMMON_DEPEND}"
DEPEND="${COMMON_DEPEND}"

DOCS=( AUTHORS README.md )

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_enable doc BUILD_DOCUMENTATION))
        cmake-utils_src_configure
}
