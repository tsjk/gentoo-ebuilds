EAPI=8

VALA_MIN_API_VERSION="0.39"
VALA_USE_DEPEND="vapigen"

inherit autotools gnome2-utils vala

DESCRIPTION="LightDM greeter forked from Unity by Linux Mint team"
HOMEPAGE="https://github.com/linuxmint/slick-greeter"

if [[ ${PV} == 9999 ]];then
	inherit git-r3
	SRC_URI=""
	KEYWORDS=""
	EGIT_REPO_URI="${HOMEPAGE}"
else
	SRC_URI="${HOMEPAGE}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
	RESTRICT="mirror"
	S="${WORKDIR}/${PN//lightdm-}-${PV}"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE=""

DEPEND="
	$(vala_depend)
	>=x11-misc/lightdm-1.30[introspection,vala]
	sys-devel/gettext
	>=dev-util/intltool-0.35.0
"
RDEPEND="${DEPEND}
	app-accessibility/onboard
	media-libs/freetype
	media-libs/libcanberra
	x11-libs/cairo
	>=x11-libs/gtk+-3.20:3
	x11-libs/libXext
	x11-libs/pixman
	x11-libs/xapp
	x11-misc/numlockx
"

src_prepare(){
	default_src_prepare
	export VALAC="$(type -P valac-$(vala_best_api_version))"
	eautoreconf
}

src_install(){
	default_src_install
	insinto /etc/lightdm
	doins "${FILESDIR}/${PN//lightdm-}.conf"
}

pkg_preinst(){
	gnome2_schemas_savelist
}

pkg_postinst(){
	gnome2_schemas_update
	einfo "To enable the slick-greeter support, set the greeter-session option"
	einfo "to 'slick-greeter' in your lightdm.conf in order to get this:"
	einfo "greeter-session=slick-greeter"
	einfo "then, restart your session and the lightdm/xdm daemon."
}

pkg_postrm(){
	gnome2_schemas_update
}
