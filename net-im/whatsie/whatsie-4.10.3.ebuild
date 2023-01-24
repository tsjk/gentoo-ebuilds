EAPI=8

PLOCALES="ca_ES cs_CZ da_DK de_DE de_DE_neu el_GR en-US en_AU en_GB en_US es_ES fr_FR he_IL hi_IN hr_HR id_ID it_IT lt_LT lv_LV nb_NO nl_NL pl_PL pt_BR pt_PT ro_RO ru_RU sk_SK sl_SI sv_SE vi_VI vi_VN"
inherit plocale qmake-utils xdg-utils

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/keshavbhatt/whatsie.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/keshavbhatt/whatsie/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
	RESTRICT="mirror"
fi

DESCRIPTION="Qt Based WhatsApp Client"
HOMEPAGE="https://github.com/keshavbhatt/whatsie"

LICENSE="MIT"
SLOT="0"
IUSE=""

RDEPEND="
	dev-qt/qtcore:5
	dev-qt/qtdeclarative:5
	dev-qt/qtgui:5
	dev-qt/qtlocation:5
	dev-qt/qtmultimedia:5
	dev-qt/qtnetwork:5
	dev-qt/qtpositioning:5
	dev-qt/qtwebengine:5
	dev-qt/qtwidgets:5
	dev-qt/qtxmlpatterns:5"
DEPEND="${RDEPEND}"
BDEPEND="
	media-libs/libglvnd[X]
	x11-libs/libX11
	x11-libs/libxcb
	virtual/pkgconfig"

S="${WORKDIR}/${P}/src"

src_configure() {
	local myeqmakeargs=(
		WhatsApp.pro
		PREFIX="${EPREFIX}/usr"
	)
	eqmake5 ${myeqmakeargs[@]}
}

src_install() {
	emake INSTALL_ROOT="${D}" install
	einstalldocs
}

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}
