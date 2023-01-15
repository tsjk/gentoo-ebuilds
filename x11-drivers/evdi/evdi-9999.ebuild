# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic git-r3 linux-mod

DESCRIPTION="Extensible Virtual Display Interface"
HOMEPAGE="https://github.com/DisplayLink/evdi"
EGIT_REPO_URI="https://github.com/DisplayLink/evdi.git"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS=""

DEPEND="x11-libs/libdrm"
RDEPEND="${DEPEND}"
BDEPEND="sys-kernel/linux-headers"

MODULE_NAMES="evdi(video:${S}/module)"

CONFIG_CHECK="~FB_VIRTUAL ~I2C"

pkg_setup() {
	linux-mod_pkg_setup
}

src_prepare() {
	default
	local KVER=$(cat "${KERNEL_DIR}/include/config/kernel.release")
	sed -i "1i KVER := ${KVER}" "${S}/Makefile" || die "sed insert of KVER failed"
}

src_compile() {
	filter-flags -fomit-frame-pointer	# x86_64-pc-linux-gnu-gcc: error: -pg and -fomit-frame-pointer are incompatible
	linux-mod_src_compile
	( cd "${S}/library" && \
		default && \
		mv libevdi.so libevdi.so.0 )
}

src_install() {
	linux-mod_src_install
	dolib.so library/libevdi.so.0
	dosym libevdi.so.0 "/usr/$(get_libdir)/libevdi.so"
}
