EAPI=7
inherit unpacker

DESCRIPTION="QEMU + Kernel-based Virtual Machine userland tools (static build from Debian)"
HOMEPAGE="http://www.qemu.org http://www.linux-kvm.org"
SRC_URI="amd64? ( mirror://debian/pool/main/q/qemu/qemu-user-static_4.2-1_amd64.deb )
	arm64? ( mirror://debian/pool/main/q/qemu/qemu-user-static_4.2-1_arm64.deb )
	armel? ( mirror://debian/pool/main/q/qemu/qemu-user-static_4.2-1_armel.deb )
	armhf? ( mirror://debian/pool/main/q/qemu/qemu-user-static_4.2-1_armhf.deb )
	mipsel? ( mirror://debian/pool/main/q/qemu/qemu-user-static_4.2-1_mipsel.deb )
	mips64el? ( mirror://debian/pool/main/q/qemu/qemu-user-static_4.2-1_mips64el.deb )
	ppc64el? ( mirror://debian/pool/main/q/qemu/qemu-user-static_4.2-1_ppc64el.deb )
	s390x? ( mirror://debian/pool/main/q/qemu/qemu-user-static_4.2-1_s390x.deb )
	x86? ( mirror://debian/pool/main/q/qemu/qemu-user-static_4.2-1_i386.deb )"

LICENSE="GPL-2 LGPL-2 BSD-2"
SLOT="0"
KEYWORDS="amd64 arm64 armel armhf mips64 mipsel ppc64el s390x x86"
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
	cd "${D}/usr/share/man/man1" && for i in *.gz; do
		[[ ! -L "${i}" ]] || { j=$(readlink "${i}"); rm "${i}"; \
					ln -sv $(echo "${j}" | sed 's@\.gz@\.bz2@') $(echo "${i}" | sed 's@\.gz@\.bz2@'); }; done
	fperms 0755 /usr/sbin/qemu-debootstrap
}

