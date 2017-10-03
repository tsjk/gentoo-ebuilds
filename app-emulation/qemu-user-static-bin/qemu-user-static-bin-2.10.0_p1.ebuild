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
	for arch in aarch64 alpha arm armeb cris hppa i386 m68k microblaze microblazeel \
		mips mips64 mips64el mipsel mipsn32 mipsn32el nios2 or1k \
		ppc ppc64 ppc64abi32 ppc64le s390x sh4 sh4eb sparc sparc32plus sparc64 \
		tilegx x86_64; do
		fperms 0755 /usr/bin/qemu-${arch}-static
	done
	fperms 0755 /usr/sbin/qemu-debootstrap
}

