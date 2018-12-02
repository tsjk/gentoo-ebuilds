# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils flag-o-matic git-r3

IUSE=""

DESCRIPTION="Converts VobSub subtitles (.sub/.idx) to .srt text subtitles using tesseract"
HOMEPAGE="https://github.com/ruediger/VobSub2SRT"
EGIT_REPO_URI="https://github.com/ruediger/VobSub2SRT"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""

RDEPEND="
	>=app-text/tesseract-2.04-r1
	<app-text/tesseract-4
	media-libs/giflib
	media-libs/leptonica
	media-libs/libpng:=
	media-libs/libwebp
	media-libs/tiff:=
	sys-libs/zlib
	virtual/ffmpeg
	virtual/jpeg:="
DEPEND="${RDEPEND}"

CMAKE_BUILD_TYPE=Release

src_prepare() {
	sed -i -E '\@CMAKE_CXX_FLAGS\ @s@\(CMAKE_CXX_FLAGS\ "([^"]*)"\)@\(CMAKE_CXX_FLAGS\ "\1\ -std=gnu++11"\)@' "${S}/CMakeLists.txt" || die
	cmake-utils_src_prepare
}

src_install() {
	cmake-utils_src_install
	echo
	gzip -dv "${D}/usr/share/man/man1/${PN}.1.gz"
	mv -v "${D}/usr/share/doc/${PN}"/* "${D}/usr/share/doc/${P}"/
	rmdir "${D}/usr/share/doc/${PN}"
	echo
}
