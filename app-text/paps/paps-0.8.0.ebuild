EAPI=8

inherit meson

DESCRIPTION="Unicode-aware text to PostScript converter"
HOMEPAGE="https://github.com/dov/paps"
SRC_URI="https://github.com/dov/${PN}/releases/download/v${PV}/${PN}-${PV}.tar.gz"
RESTRICT="mirror"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="amd64 x86"

RDEPEND="
	dev-libs/libfmt
	x11-libs/pango
"
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"

src_install() {
	meson_src_install
	dodoc AUTHORS ChangeLog NEWS README README.md
}
