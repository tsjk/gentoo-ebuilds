EAPI=8

inherit unpacker

DESCRIPTION="Additional proprietary codecs for opera"
HOMEPAGE="http://ffmpeg.org/"
SRC_URI="https://github.com/nwjs-ffmpeg-prebuilt/nwjs-ffmpeg-prebuilt/releases/download/0.103.1/0.103.1-linux-x64.zip"

LICENSE="LGPL2.1"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=""
RDEPEND="
	|| ( www-client/opera[-proprietary-codecs] www-client/opera-beta[-proprietary-codecs] )"

RESTRICT="mirror strip"

S="${WORKDIR}"

src_unpack() {
	unpack ${A}
}

src_compile() {
	:
}

src_install() {
	dodir opt/opera-ffmpeg-codecs-bin
	insinto opt/opera-ffmpeg-codecs-bin
	doins ${S}/libffmpeg.so
}

pkg_postinst() {
	if has_version 'www-client/opera[-proprietary-codecs]'; then
		if [[ ! -f "${EROOT}"/opt/opera/libffmpeg.so.opera ]]; then
			mv -v "${EROOT}"/opt/opera/libffmpeg.so{,.opera} && \
				chmod a-r "${EROOT}"/opt/opera/libffmpeg.so.opera || die
		fi
		[[ ! -L "${EROOT}"/opt/opera/libffmpeg.so ]] || rm "${EROOT}"/opt/opera/libffmpeg.so
		ln -s -v ../opera-ffmpeg-codecs-bin/libffmpeg.so "${EROOT}"/opt/opera/libffmpeg.so || die
	fi
	if has_version 'www-client/opera-beta[-proprietary-codecs]'; then
		if [[ ! -f "${EROOT}"/opt/opera-beta/libffmpeg.so.opera ]]; then
			mv -v "${EROOT}"/opt/opera-beta/libffmpeg.so{,.opera} && \
				chmod a-r "${EROOT}"/opt/opera-beta/libffmpeg.so.opera || die
		fi
		[[ ! -L "${EROOT}"/opt/opera/libffmpeg.so ]] || rm "${EROOT}"/opt/opera-beta/libffmpeg.so
		ln -s -v ../opera-ffmpeg-codecs-bin/libffmpeg.so "${EROOT}"/opt/opera-beta/libffmpeg.so || die
	fi
}

pkg_prerm() {
	rm -f "${EROOT}"/opt/opera-beta/libffmpeg.so "${EROOT}"/opt/opera/libffmpeg.so
	[[ ! -f "${EROOT}"/opt/opera-beta/libffmpeg.so.opera ]] || {
		mv "${EROOT}"/opt/opera-beta/libffmpeg.so{.opera,}
		chmod a+r "${EROOT}"/opt/opera-beta/libffmpeg.so
	}
	[[ ! -f "${EROOT}"/opt/opera/libffmpeg.so.opera ]] || {
		mv "${EROOT}"/opt/opera/libffmpeg.so{.opera,}
		chmod a+r "${EROOT}"/opt/opera/libffmpeg.so
	}
}

_update() {
 ( set -x; f=$(curl -qs 'https://github.com/nwjs-ffmpeg-prebuilt/nwjs-ffmpeg-prebuilt/releases' | grep -E '"/nwjs-ffmpeg-prebuilt/nwjs-ffmpeg-prebuilt/releases/download/[0-9\.]+/[0-9\.]+-linux-x64\.zip"' | sort -V | tail -n 1) )
}
