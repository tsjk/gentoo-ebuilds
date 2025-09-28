EAPI=8

inherit unpacker

DESCRIPTION="Additional proprietary codecs for vivaldi"
HOMEPAGE="http://ffmpeg.org/"
SRC_URI="https://github.com/nwjs-ffmpeg-prebuilt/nwjs-ffmpeg-prebuilt/releases/download/0.103.1/0.103.1-linux-x64.zip"

LICENSE="LGPL2.1"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=""
RDEPEND="www-client/vivaldi[-proprietary-codecs]"

RESTRICT="mirror strip"

S="${WORKDIR}"

src_unpack() {
	unpack ${A}
}

src_compile() {
	:
}

src_install() {
	dodir opt/vivaldi-ffmpeg-codecs-bin
	insinto opt/vivaldi-ffmpeg-codecs-bin
	doins ${S}/libffmpeg.so
}

pkg_postinst() {
	if [[ ! -f "${EROOT}"/opt/vivaldi/lib/libffmpeg.so.vivaldi ]]; then
		mv -v "${EROOT}"/opt/vivaldi/lib/libffmpeg.so{,.vivaldi} && \
			chmod a-r "${EROOT}"/opt/vivaldi/lib/libffmpeg.so.vivaldi || die
	fi
	[[ ! -L "${EROOT}"/opt/vivaldi/lib/libffmpeg.so ]] || rm "${EROOT}"/opt/vivaldi/lib/libffmpeg.so
	ln -s -v ../../vivaldi-ffmpeg-codecs-bin/libffmpeg.so "${EROOT}"/opt/vivaldi/lib/libffmpeg.so || die
}

pkg_prerm() {
	rm -f "${EROOT}"/opt/vivaldi/lib/libffmpeg.so
	[[ ! -f "${EROOT}"/opt/vivaldi/lib/libffmpeg.so.vivaldi ]] || {
		mv "${EROOT}"/opt/vivaldi/lib/libffmpeg.so{.vivaldi,}
		chmod a+r "${EROOT}"/opt/vivaldi/lib/libffmpeg.so
	}
}

_update() {
 ( set -x; f=$(curl -qs 'https://github.com/nwjs-ffmpeg-prebuilt/nwjs-ffmpeg-prebuilt/releases' | grep -E '"/nwjs-ffmpeg-prebuilt/nwjs-ffmpeg-prebuilt/releases/download/[0-9\.]+/[0-9\.]+-linux-x64\.zip"' | sort -V | tail -n 1) )
}
