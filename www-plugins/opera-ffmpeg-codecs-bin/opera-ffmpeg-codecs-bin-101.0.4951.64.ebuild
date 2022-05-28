EAPI=7

inherit eutils unpacker

DESCRIPTION="Additional proprietary codecs for opera"
HOMEPAGE="http://ffmpeg.org/"
SRC_URI="http://security.ubuntu.com/ubuntu/pool/universe/c/chromium-browser/chromium-codecs-ffmpeg-extra_101.0.4951.64-0ubuntu0.18.04.1_amd64.deb"

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

_update() {
 ( set -x; f=$(curl -qs 'http://security.ubuntu.com/ubuntu/pool/universe/c/chromium-browser/' | grep -oP '(?<=")chromium-codecs-ffmpeg-extra_[^"]*_amd64\.deb' | sort -V | tail -n 1) && \
   v=$(grep -o -P '(?<=extra_)[0-9\.]+(?=-)' <<< "${f}") && f_pv=$(sed -E "s@extra_${v}-@extra_\$\{PV\}@" <<< "${v}") && \
   e=$(ls -1 *.ebuild | sort -V | head -n 1) && sed -i -E '\@^SRC_URI=@s@\/[^\/]+\.deb"$@\/'"${f}"'"@' "${e}" && \
   E=$(ls -1 *.ebuild | sort -V | head -n 1 | sed "s@-bin-.*@-bin-${v}.ebuild@") && { [[ "${e}" == "${E}" ]] || mv -v "${e}" "${E}"; } && repoman manifest )
}
