EAPI=8

inherit ecm kde.org

DESCRIPTION="Plasma 5 applet to disable screensaver and auto-suspend"
HOMEPAGE="https://github.com/qunxyz/plasma-applet-caffeine-plus"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="${HOMEPAGE}"
else
	SRC_URI="${HOMEPAGE}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm ~arm64 ~x86"
fi

LICENSE="GPL-2"
SLOT="5"

DEPEND="
	kde-frameworks/plasma:5
	kde-frameworks/extra-cmake-modules:5
	kde-frameworks/kio:5
	dev-qt/qtquickcontrols2:5
	dev-qt/qtcore:5
"
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		-Wno-dev
	)

        cmake_src_configure
}
