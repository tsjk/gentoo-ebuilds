EAPI=8

inherit desktop unpacker xdg-utils

DESCRIPTION="Haveno is a non-custodial, decentralized exchange platform for crypto and fiat currencies built on Tor and Monero"
HOMEPAGE="https://haveno.exchange https://github.com/retoaccess1/haveno-reto"
SRC_URI="https://github.com/retoaccess1/haveno-reto/releases/download/${PV}/haveno-v${PV}-linux-x86_64-installer.deb -> ${P}.deb"

LICENSE="GPLv3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="
	app-arch/xz-utils
	dev-java/openjfx
	dev-libs/expat
	dev-libs/libgpg-error
	dev-libs/libpcre-debian
        net-libs/libnet
	sys-apps/dbus
	sys-libs/libcap
	x11-misc/xdg-utils
	sys-libs/zlib
        virtual/jre:*
"

RESTRICT="mirror strip"

# Bundled java, and seems to mostly work without an old ffmpeg
QA_PREBUILT="opt/haveno/bin/Haveno opt/haveno/lib/libapplauncher.so opt/haveno/lib/runtime/lib/*"
REQUIRES_EXCLUDE="libavcodec.so.54 libavformat.so.54 libavcodec.so.56 libavformat.so.56 libavcodec.so.57 libavformat.so.57 libavcodec.so.58 libavformat.so.58 libavcodec-ffmpeg.so.56 libavformat-ffmpeg.so.56"

S="${WORKDIR}"

src_unpack() {
	unpack_deb "${P}.deb"
}

src_compile() {
	:
}

src_install() {
	dodir /opt
	sed -i -E 's@^Categories=Network$@Categories=Office\;Finance\;P2P\;Network\;@' "${S}"/opt/haveno/lib/haveno-Haveno.desktop
	cp -ar "${S}"/opt/haveno "${ED}"/opt/
	dosym ../haveno/bin/Haveno /opt/bin/Haveno
	domenu opt/haveno/lib/haveno-Haveno.desktop
        doicon opt/haveno/lib/Haveno.png
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_icon_cache_update
	xdg_mimeinfo_database_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_icon_cache_update
	xdg_mimeinfo_database_update
}
