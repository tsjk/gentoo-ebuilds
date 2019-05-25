EAPI=7

inherit eutils git-r3 qmake-utils

DESCRIPTION="Powerful and easy-to-use multimedia player"
HOMEPAGE="http://bomi-player.github.io/"
#EGIT_REPO_URI="https://github.com/xylosper/bomi.git"
EGIT_REPO_URI="https://github.com/demokritos/bomi.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="cdda jack pulseaudio samba systemd"

RDEPEND="dev-libs/fribidi
	dev-libs/icu
	dev-libs/libchardet
	>=dev-qt/qtcore-5.3
	>=dev-qt/qtdbus-5.3
	>=dev-qt/qtdeclarative-5.3[-gles2]
	>=dev-qt/qtgui-5.3[-gles2]
	>=dev-qt/qtnetwork-5.3
	>=dev-qt/qtopengl-5.3[-gles2]
	>=dev-qt/qtquickcontrols-5.3
	>=dev-qt/qtsql-5.3
	>=dev-qt/qtwidgets-5.3[-gles2]
	>=dev-qt/qtx11extras-5.3
	>=dev-qt/qtxml-5.3
	media-libs/alsa-lib
	>=media-video/ffmpeg-3.2
	media-libs/glew
	>=media-libs/libass-0.14
	media-libs/libbluray
	>=media-libs/libquvi-0.9
	media-libs/libdvdread
	media-libs/libdvdnav
	media-sound/mpg123
	x11-libs/libva
	cdda? (
		dev-libs/libcdio
		dev-libs/libcdio-paranoia )
	jack? ( media-sound/jack-audio-connection-kit )
	pulseaudio? ( media-sound/pulseaudio )
	samba? ( net-fs/samba[client] )
	systemd? ( sys-apps/systemd )
	virtual/opengl"
DEPEND="${RDEPEND}
	dev-lang/python
	media-libs/mesa
	sys-apps/sed
	>=sys-devel/gcc-6.4"

DOCS=(	"CHANGES.txt" "COPYING.txt" "CREDITS.txt" "GPL.txt" \
	"ICON-AUTHORS.txt" "ICON-COPYING.txt" "MPL.txt" "README.md" )

src_configure() {
	./configure \
		--qtsdk=/usr/$(get_libdir)/qt5 \
		--qmake=/usr/$(get_libdir)/qt5/bin/qmake \
		--prefix=/usr \
		$(use_enable cdda) \
		$(use_enable jack) \
		$(use_enable pulseaudio) \
		$(use_enable samba) \
		$(use_enable systemd) \
		|| die
}

src_install() {
	emake DEST_DIR="${D}" install
	for doc in "${DOCS[@]}"; do dodoc "${doc}"; done
}
