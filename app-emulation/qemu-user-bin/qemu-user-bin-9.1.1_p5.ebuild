EAPI=8
inherit unpacker

DESCRIPTION="QEMU + Kernel-based Virtual Machine userland tools (static build from Debian)"
HOMEPAGE="http://www.qemu.org http://www.linux-kvm.org"
SRC_URI="amd64? ( mirror://debian/pool/main/q/qemu/qemu-user_9.1.1+ds-5_amd64.deb )
	arm? ( mirror://debian/pool/main/q/qemu/qemu-user_9.1.1+ds-5_armhf.deb )
	arm64? ( mirror://debian/pool/main/q/qemu/qemu-user_9.1.1+ds-5_arm64.deb )
	ppc64? ( mirror://debian/pool/main/q/qemu/qemu-user_9.1.1+ds-5_ppc64el.deb )
	x86? ( mirror://debian/pool/main/q/qemu/qemu-user_9.1.1+ds-5_i386.deb )"

LICENSE="GPL-2 LGPL-2 BSD-2"
SLOT="0"
KEYWORDS="amd64 arm arm64 ppc64 x86"
RESTRICT="mirror"
DEPEND=""

S=${WORKDIR}

QA_PRESTRIPPED="usr/bin/qemu-user-bin-*"

src_unpack() {
	unpack_deb ${A}
}

src_install() {
	gunzip usr/share/doc/qemu-user/changelog.Debian.gz
	gunzip usr/share/doc/qemu-user/main.rst.gz
	gunzip usr/share/man/man1/qemu-user.1.gz
	mv usr/share/doc/qemu-user{,-bin-${PV}}
	mv usr/share/man/man1/qemu-user{,-bin}.1
	insinto /usr
	doins -r usr/{bin,libexec,share}
	for f in "${ED}/usr/bin"/qemu-*; do
		[[ -L "${f}" ]] || fperms 0755 /usr/bin/$(basename "${f}")
	done
	( cd "${ED}/usr/bin" && {
		for f in qemu-*; do
			if [[ -L "${f}" ]]; then
				l=$(readlink "${f}"); rm "${f}"; ln -s "${l/qemu-/qemu-user-bin-}" "${f/qemu-/qemu-user-bin-}"
			else
				mv "${f}" "${f/qemu-/qemu-user-bin-}"
			fi
		done
	} )
	cd "${D}/usr/share/man/man1" && { \
		for i in *.gz; do [[ ! -L "${i}" ]] || { \
			j=$(readlink "${i}"); rm "${i}"; \
			ln -sv "${PN}.1.bz2" $(echo "${i}" | sed 's@^qemu-@qemu-user-bin-@; s@\.gz@\.bz2@'); \
		}; done
	}
}
