# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 toolchain-funcs

DESCRIPTION="USB hub per-port power control"
HOMEPAGE="https://github.com/mvp/uhubctl"
EGIT_REPO_URI="https://github.com/mvp/uhubctl.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""

DEPEND="virtual/libusb:1"
RDEPEND="${DEPEND}"
BDEPEND="virtual/pkgconfig"

src_prepare() {
	default
	tc-export PKG_CONFIG
}

src_compile() {
	emake CC="$(tc-getCC)"
}
