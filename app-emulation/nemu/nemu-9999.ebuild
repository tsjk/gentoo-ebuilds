# Copyright 2019-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake linux-info git-r3

DESCRIPTION="ncurses interface for QEMU"
HOMEPAGE="https://github.com/nemuTUI/nemu"
EGIT_REPO_URI="https://github.com/nemuTUI/nemu"
SRC_URI=""

LICENSE="BSD-2"
SLOT="0"
KEYWORDS=""
IUSE="dbus +ovf remote-api +spice svg +vnc-client"

RDEPEND="
	>=app-emulation/qemu-6.0.0-r3[vnc,virtfs,spice?]
	dev-db/sqlite:3=
	dev-libs/json-c
	sys-libs/ncurses:=[unicode(+)]
	virtual/libusb:1
	virtual/libudev:=
	dbus? ( sys-apps/dbus )
	ovf? (
		dev-libs/libxml2:2
		app-arch/libarchive:=
	)
	remote-api? ( dev-libs/openssl )
	spice? ( app-emulation/virt-viewer )
	svg? ( media-gfx/graphviz[svg] )
	vnc-client? ( net-misc/tigervnc )
"
DEPEND="
	${RDEPEND}
"
BDEPEND="
		sys-devel/gettext
"

pkg_pretend() {
	if use kernel_linux; then
		if ! linux_config_exists; then
			eerror "Unable to check your kernel"
		else
			CONFIG_CHECK="~VETH ~MACVTAP"
			ERROR_VETH="You will need the Virtual ethernet pair device driver compiled"
			ERROR_VETH+=" into your kernel or loaded as a module to use the"
			ERROR_VETH+=" local network settings feature."
			ERROR_MACVTAP="You will also need support for MAC-VLAN based tap driver."

			check_extra_config
		fi
	fi
}

src_configure() {
	local mycmakeargs=(
		-DNM_WITH_DBUS=$(usex dbus)
		-DNM_WITH_NCURSES=off
		-DNM_WITH_NETWORK_MAP=$(usex svg)
		-DNM_WITH_REMOTE=$(usex remote-api)
		-DNM_WITH_OVF_SUPPORT=$(usex ovf)
		-DNM_WITH_QEMU=off
		-DNM_WITH_SPICE=$(usex spice)
		-DNM_WITH_VNC_CLIENT=$(usex vnc-client)
		-DCMAKE_INSTALL_PREFIX=/usr
	)
	cmake_src_configure
}

src_install() {
	cmake_src_install
	docompress -x /usr/share/man/man1/nemu.1.gz
}

pkg_postinst() {
	elog "For non-root usage execute script:"
	elog "/usr/share/nemu/scripts/setup_nemu_nonroot.sh linux <username>"
	elog "and add udev rule:"
	elog "cp -a /usr/share/nemu/scripts/42-net-macvtap-perm.rules /etc/udev/rules.d"
	elog "Afterwards reboot or reload udev with"
	elog "udevadm control --reload-rules && udevadm trigger"
}
