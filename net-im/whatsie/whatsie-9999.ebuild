EAPI=8

PLOCALES="ca_ES cs_CZ da_DK de_DE de_DE_neu el_GR en-US en_AU en_GB en_US es_ES fr_FR he_IL hi_IN hr_HR id_ID it_IT lt_LT lv_LV nb_NO nl_NL pl_PL pt_BR pt_PT ro_RO ru_RU sk_SK sl_SI sv_SE vi_VI vi_VN"
inherit cmake plocale xdg-utils

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/keshavbhatt/whatsie.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/keshavbhatt/whatsie/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	SRC_URI+=" https://github.com/ahm-forks/libnotify-qt/archive/refs/tags/1.0.0.tar.gz -> libnotify-qt-1.0.0.tar.gz"
	KEYWORDS="~amd64"
	RESTRICT="mirror"
fi

DESCRIPTION="Qt Based WhatsApp Client"
HOMEPAGE="https://github.com/keshavbhatt/whatsie"

LICENSE="MIT"
SLOT="0"
IUSE=""

QT_MIN="6.10"

DEPEND="
	x11-libs/libX11
	x11-libs/libxcb:=
	>=dev-qt/qtbase-${QT_MIN}:6
	>=dev-qt/qtdeclarative-${QT_MIN}:6
	>=dev-qt/qtlocation-${QT_MIN}:6
	>=dev-qt/qtpositioning-${QT_MIN}:6
	>=dev-qt/qttools-${QT_MIN}:6
	>=dev-qt/qtwebengine-${QT_MIN}:6[widgets]
"

RDEPEND="${DEPEND}"

BDEPEND="
	media-libs/libglvnd[X]
	x11-libs/libX11
	x11-libs/libxcb
	virtual/pkgconfig"

src_unpack() {
	default
	if [[ ${PV} == *9999* ]]; then
		cd "${EGIT_SOURCEDIR}"
		git submodule update --init --recursive
	else
		rmdir "${S}/src/libnotify-qt"
		mv "${WORKDIR}/libnotify-qt-1.0.0" "${S}/src/libnotify-qt"
	fi
}

src_prepare() {
	if tc-enables-fortify-source ; then
		filter-flags -D_FORTIFY_SOURCE=3
	fi
	cmake_src_prepare
}

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}
