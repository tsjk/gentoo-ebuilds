EAPI=7

inherit eutils unpacker

DESCRIPTION="Additional proprietary codecs for opera"
HOMEPAGE="http://ffmpeg.org/"
SRC_URI="http://security.ubuntu.com/ubuntu/pool/universe/c/chromium-browser/chromium-codecs-ffmpeg-extra_${PV}-0ubuntu0.18.04.1_amd64.deb"

LICENSE="LGPL2.1"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=""
RDEPEND="
	!www-plugins/opera-ffmpeg-codecs
	www-client/opera"

RESTRICT="mirror strip"

S="${WORKDIR}"

src_unpack() {
	unpack_deb ${A}
}

src_compile() {
	:
}

src_install() {
	dodir usr/$(get_libdir)/opera/lib_extra
	insinto usr/$(get_libdir)/opera/lib_extra
	doins ${S}/usr/lib/chromium-browser/libffmpeg.so
}
