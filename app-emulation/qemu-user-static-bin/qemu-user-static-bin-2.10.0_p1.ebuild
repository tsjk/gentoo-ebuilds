EAPI=6
inherit unpacker

DESCRIPTION="QEMU + Kernel-based Virtual Machine userland tools (static build from Debian)"
HOMEPAGE="http://www.qemu.org http://www.linux-kvm.org"
SRC_URI="mirror://debian/pool/main/q/qemu/qemu-user-static_2.10.0+dfsg-1_amd64.deb"

LICENSE="GPL-2 LGPL-2 BSD-2"
SLOT="0"
KEYWORDS="amd64"
RESTRICT="mirror"
DEPEND=""

S=${WORKDIR}

src_unpack() {
	unpack_deb ${A}
}

src_install() {
	insinto /usr
	doins -r usr/{bin,sbin,share}
}

