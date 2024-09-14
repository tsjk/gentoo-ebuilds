EAPI=8

inherit cmake

DESCRIPTION="GUI configuration tool for Picom X composite manager"
HOMEPAGE="https://qtilities.github.io/"
SRC_URI="https://github.com/qtilities/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="mirror"

RDEPEND="
	dev-libs/libconfig
        dev-qt/qtbase
        sys-auth/polkit
        x11-misc/picom
"
DEPEND="${RDEPEND}"
BDEPEND="
        dev-build/cmake
        dev-build/qtilitools
        dev-qt/linguist-tools
        dev-qt/qttools
"
