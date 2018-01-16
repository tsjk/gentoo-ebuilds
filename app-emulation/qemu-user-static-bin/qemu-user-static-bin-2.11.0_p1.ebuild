EAPI=6
inherit unpacker

DESCRIPTION="QEMU + Kernel-based Virtual Machine userland tools (static build from Debian)"
HOMEPAGE="http://www.qemu.org http://www.linux-kvm.org"
SRC_URI="amd64? ( mirror://debian/pool/main/q/qemu/qemu-user-static_2.11+dfsg-1_amd64.deb )
	arm64? ( mirror://debian/pool/main/q/qemu/qemu-user-static_2.11+dfsg-1_arm64.deb )
	armel? ( mirror://debian/pool/main/q/qemu/qemu-user-static_2.11+dfsg-1_armel.deb )
	armhf? ( mirror://debian/pool/main/q/qemu/qemu-user-static_2.11+dfsg-1_armhf.deb )
	mips? ( mirror://debian/pool/main/q/qemu/qemu-user-static_2.11+dfsg-1_mips.deb )
	mipsel? ( mirror://debian/pool/main/q/qemu/qemu-user-static_2.11+dfsg-1_mipsel.deb )
	powerpc? ( mirror://debian/pool/main/q/qemu/qemu-user-static_2.11+dfsg-1_powerpc.deb )
	ppc64el? ( mirror://debian/pool/main/q/qemu/qemu-user-static_2.11+dfsg-1_ppc64el.deb )
	s390x? ( mirror://debian/pool/main/q/qemu/qemu-user-static_2.11+dfsg-1_s390x.deb )
	x86? ( mirror://debian/pool/main/q/qemu/qemu-user-static_2.11+dfsg-1_i386.deb )"

LICENSE="GPL-2 LGPL-2 BSD-2"
SLOT="0"
KEYWORDS="amd64 arm64 armel armhf mips mips64 mipsel powerpc ppc64el s390x x86"
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

