# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit cmake-utils

DESCRIPTION="LightDM LXQt greeter"
HOMEPAGE="http://www.lxqt.org/"

if [[ ${PV} = *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="git://git.lxde.org/git/lxde/${PN}.git"
	KEYWORDS=""
else
	SRC_URI="mirror://sourceforge/lxde/${P}.tar.bz2"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="LGPL-2.1+"
SLOT="0"
IUSE=""

RDEPEND="
    sys-libs/zlib
    x11-libs/libXcursor
    x11-libs/libXfixes
    dev-qt/qtcore:5
    dev-qt/qtgui:5
    dev-qt/qtwidgets:5
    lxqt-base/liblxqt
    >=dev-libs/libqtxdg-1.0.0
    x11-misc/lightdm
"
DEPEND="${RDEPEND}
    virtual/pkgconfig"

PATCHES=( "${FILESDIR}/${P}-add-qtlibdir.patch" )

src_configure() {
	QMAKE="/usr/lib/qt5/qmake"
        local mycmakeargs=(
		-DUSE_QT5=ON
        )
        cmake-utils_src_configure
}

