# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..13} )
inherit flag-o-matic git-r3 linux-mod python-single-r1

DESCRIPTION="Extensible Virtual Display Interface"
HOMEPAGE="https://github.com/DisplayLink/evdi"
EGIT_REPO_URI="https://github.com/DisplayLink/evdi.git"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0/$(ver_cut 1-2)"
KEYWORDS=""
IUSE="python"

RDEPEND="${PYTHON_DEPS}
	python? ( $(python_gen_cond_dep 'dev-python/pybind11[${PYTHON_USEDEP}]') )
	x11-libs/libdrm
"

DEPEND="${RDEPEND}
	sys-kernel/linux-headers
"

REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"

CONFIG_CHECK="~FB_VIRTUAL ~I2C DRM ~USB_SUPPORT USB_ARCH_HAS_HCD MODULES"

MODULE_NAMES="evdi(video:${S}/module)"

pkg_setup() {
	linux-mod_pkg_setup
	use python && python-single-r1_pkg_setup
}

src_prepare() {
	default
	sed -i "1i KVER := ${KV_FULL}" "${S}/module/Makefile" || die "sed insert of KVER failed"
}

src_compile() {
	local modlist=( evdi=video:module )
	local modargs=( CONFIG_DRM_EVDI="m" KVER="${KV_FULL}" KDIR="${KV_OUT_DIR}" )
	filter-lto
	filter-flags -fomit-frame-pointer	# x86_64-pc-linux-gnu-gcc: error: -pg and -fomit-frame-pointer are incompatible
	linux-mod_src_compile
	emake -C library
	use python && emake -C pyevdi
}

src_install() {
	linux-mod_src_install
	MYLIBDIR="${EPREFIX}/usr/$(get_libdir)"
	emake DESTDIR="${ED}" PREFIX="${EPREFIX}" LIBDIR="${MYLIBDIR}" -C library install
	use python && emake DESTDIR="${ED}" PREFIX="${EPREFIX}" -C pyevdi install
}
