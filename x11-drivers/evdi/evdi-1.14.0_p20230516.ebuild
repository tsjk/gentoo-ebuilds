# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic linux-mod

COMMIT="eb83c2e3937f7e2cfaa78ac5e5e5be17c32a2f9e"
DESCRIPTION="Extensible Virtual Display Interface"
HOMEPAGE="https://github.com/DisplayLink/evdi"
SRC_URI="https://github.com/DisplayLink/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS=""
RESTRICT="mirror"

DEPEND="x11-libs/libdrm"
RDEPEND="${DEPEND}"
BDEPEND="sys-kernel/linux-headers"

S="${WORKDIR}/${PN}-${COMMIT}"

MODULE_NAMES="evdi(video:${S}/module)"

CONFIG_CHECK="~FB_VIRTUAL ~I2C"

pkg_setup() {
	linux-mod_pkg_setup
}

src_prepare() {
	default
	sed -i "1i KVER := ${KV_FULL}" "${S}/module/Makefile" || die "sed insert of KVER failed"
}

src_compile() {
	filter-flags -fomit-frame-pointer	# x86_64-pc-linux-gnu-gcc: error: -pg and -fomit-frame-pointer are incompatible
	linux-mod_src_compile
	( cd "${S}/library" && \
		default && \
		mv libevdi.so libevdi.so.1 )
}

src_install() {
	linux-mod_src_install
	dolib.so library/libevdi.so.1
	dosym libevdi.so.1 "/usr/$(get_libdir)/libevdi.so"
}
