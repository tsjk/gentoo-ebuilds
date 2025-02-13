
EAPI=8
inherit unpacker

DESCRIPTION="QEMU + Kernel-based Virtual Machine userland tools (static build from Debian)"
HOMEPAGE="http://www.qemu.org http://www.linux-kvm.org"
SRC_URI="amd64? ( mirror://debian/pool/main/q/qemu/qemu-user_9.2.0+ds-4_amd64.deb )
	arm? ( mirror://debian/pool/main/q/qemu/qemu-user_9.2.0+ds-4_armhf.deb )
	arm64? ( mirror://debian/pool/main/q/qemu/qemu-user_9.2.0+ds-4_arm64.deb )
	ppc64? ( mirror://debian/pool/main/q/qemu/qemu-user_9.2.0+ds-4_ppc64el.deb )
	x86? ( mirror://debian/pool/main/q/qemu/qemu-user_9.2.0+ds-4_i386.deb )"

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
				l=$(readlink "${f}"); rm "${f}"; ln -s "$(echo "${l}" | sed -E 's@^qemu-(.+)@qemu-\1-user-bin@')" "$(echo "${f}" | sed -E 's@^qemu-(.+)@qemu-\1-user-bin@')"
			else
				mv "${f}" "$(echo "${f}" | sed -E 's@^qemu-([^\.]+)@qemu-\1-user-bin@')"
			fi
		done
	} )
	( cd "${ED}/usr/libexec/qemu-binfmt" && {
		for f in *; do
			if [[ -L "${f}" ]]; then
				l=$(readlink "${f}"); rm "${f}"; ln -s "$(echo "${l}" | sed -E 's@/qemu-(.+)@/qemu-\1-user-bin@')" "$(echo "${f}" | sed -E 's@^(.+)-binfmt-P@\1-user-bin-binfmt-P@')"
			fi
		done
	} )
	( cd "${ED}/usr/share/qemu/binfmt.d" && {
		for f in qemu-*; do
			sed -i -E 's@:/usr/libexec/qemu-binfmt/(.+)-binfmt-P:@:/usr/libexec/qemu-binfmt/\1-user-bin-binfmt-P:@' "${f}"
			mv "${f}" "$(echo "${f}" | sed -E 's@^qemu-([^\.]+)@qemu-\1-user-bin@')"
		done
	} )
	cd "${D}/usr/share/man/man1" && { \
		for i in *.gz; do [[ ! -L "${i}" ]] || { \
			j=$(readlink "${i}"); rm "${i}"; \
			ln -s "${PN}.1.bz2" $(echo "${i}" | sed -E 's@^qemu-([^\.]+)@qemu-\1-user-bin@; s@\.gz@\.bz2@'); \
		}; done
	}
}
