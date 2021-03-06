EAPI=7
inherit unpacker

DESCRIPTION="QEMU + Kernel-based Virtual Machine userland tools (static build from Debian)"
HOMEPAGE="http://www.qemu.org http://www.linux-kvm.org"
SRC_URI="amd64? ( mirror://debian/pool/main/q/qemu/qemu-user-static_5.2+dfsg-2_amd64.deb )
	arm64? ( mirror://debian/pool/main/q/qemu/qemu-user-static_5.2+dfsg-2_arm64.deb )
	armel? ( mirror://debian/pool/main/q/qemu/qemu-user-static_5.2+dfsg-2_armel.deb )
	armhf? ( mirror://debian/pool/main/q/qemu/qemu-user-static_5.2+dfsg-2_armhf.deb )
	mipsel? ( mirror://debian/pool/main/q/qemu/qemu-user-static_5.2+dfsg-2_mipsel.deb )
	mips64el? ( mirror://debian/pool/main/q/qemu/qemu-user-static_5.2+dfsg-2_mips64el.deb )
	ppc64el? ( mirror://debian/pool/main/q/qemu/qemu-user-static_5.2+dfsg-2_ppc64el.deb )
	s390x? ( mirror://debian/pool/main/q/qemu/qemu-user-static_5.2+dfsg-2_s390x.deb )
	x86? ( mirror://debian/pool/main/q/qemu/qemu-user-static_5.2+dfsg-2_i386.deb )"

LICENSE="GPL-2 LGPL-2 BSD-2"
SLOT="0"
KEYWORDS="amd64 arm64 armel armhf mipsel mips64el ppc64el s390x x86"
RESTRICT="mirror"
DEPEND=""

S=${WORKDIR}

src_unpack() {
	unpack_deb ${A}
}

src_install() {
	insinto /usr
	doins -r usr/{bin,sbin,share}
	for f in "${ED}/usr/bin"/qemu-*-static; do
		fperms 0755 /usr/bin/$(basename "${f}")
	done
	cd "${D}/usr/share/man/man1" && for i in *.gz; do
		[[ ! -L "${i}" ]] || { j=$(readlink "${i}"); rm "${i}"; \
					ln -sv $(echo "${j}" | sed 's@\.gz@\.bz2@') $(echo "${i}" | sed 's@\.gz@\.bz2@'); }; done
	fperms 0755 /usr/sbin/qemu-debootstrap
}

