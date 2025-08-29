
EAPI=8
inherit unpacker

DESCRIPTION="QEMU + Kernel-based Virtual Machine userland tools (static build from Debian)"
HOMEPAGE="http://www.qemu.org http://www.linux-kvm.org"
SRC_URI="amd64? ( mirror://debian/pool/main/q/qemu/qemu-user_10.1.0+ds-1_amd64.deb mirror://debian/pool/main/q/qemu/qemu-user-binfmt_10.1.0+ds-1_arm64.deb )
	arm? ( mirror://debian/pool/main/q/qemu/qemu-user_10.1.0+ds-1_armhf.deb mirror://debian/pool/main/q/qemu/qemu-user-binfmt_10.1.0+ds-1_armhf.deb )
	arm64? ( mirror://debian/pool/main/q/qemu/qemu-user_10.1.0+ds-1_arm64.deb mirror://debian/pool/main/q/qemu/qemu-user-binfmt_10.1.0+ds-1_arm64.deb )
	ppc64? ( mirror://debian/pool/main/q/qemu/qemu-user_10.1.0+ds-1_ppc64el.deb mirror://debian/pool/main/q/qemu/qemu-user-binfmt_10.1.0+ds-1_ppc64el.deb )
	x86? ( mirror://debian/pool/main/q/qemu/qemu-user_10.1.0+ds-1_i386.deb mirror://debian/pool/main/q/qemu/qemu-user-binfmt_10.1.0+ds-1_i386.deb )"

LICENSE="GPL-2 LGPL-2 BSD-2"
SLOT="0"
KEYWORDS="amd64 arm arm64 ppc64 x86"
RESTRICT="mirror"
DEPEND=""

S=${WORKDIR}

QA_PRESTRIPPED="usr/bin/qemu-user-bin-*"

src_unpack() {
	local -a debs
	readarray -t -d '' debs < <(find "${DISTDIR}" -maxdepth 1 -name '*.deb' -print0 || die)
	local deb
	for deb in "${debs[@]}"; do unpack_deb ${deb}; done
}

src_install() {
	gunzip usr/share/doc/qemu-user/changelog.Debian.gz
	gunzip usr/share/doc/qemu-user/main.rst.gz
	gunzip usr/share/man/man1/qemu-user.1.gz
	mv usr/share/doc/qemu-user{,-bin-${PV}}
	mv usr/share/man/man1/qemu-user{,-bin}.1
	rm usr/share/doc/qemu-user-binfmt
	insinto /usr
	doins -r usr/{bin,lib,share}
	local f
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
	local -a q
	readarray -t -d '' q < <(find "${ED}/usr/bin" -name 'qemu-*-user-bin' -printf '%f\0' || die)
	mkdir -p "${ED}/usr/libexec/qemu-binfmt"
	( cd "${ED}/usr/libexec/qemu-binfmt" && { for f in "${q[@]}"; do ln -s ../../bin/${f} "${f#qemu-}-binfmt-P"; done; } )
	( cd "${ED}/usr/share/qemu/binfmt.d" && {
		for f in qemu-*; do
			sed -i -E 's@:/usr/bin/(.+):@:/usr/libexec/qemu-binfmt/\1-user-bin-binfmt-P:@' "${f}"
			mv "${f}" "$(echo "${f}" | sed -E 's@^qemu-([^\.]+)@qemu-\1-user-bin@')"
		done
	} )
	( cd "${ED}/usr/lib/binfmt.d" && {
		find . -maxdepth 1 -name '*.conf' -type l -delete
		readarray -t -d '' q < <(find "../../share/qemu/binfmt.d" -name 'qemu-*-user-bin.conf' -printf '%f\0' || die)
		for f in "${q[@]}"; do ln -s ../../share/qemu/binfmt.d/${f}; done
	} )
	( cd "${D}/usr/share/man/man1" && { \
		for i in *.gz; do [[ ! -L "${i}" ]] || { \
			j=$(readlink "${i}"); rm "${i}"; \
			ln -s "${PN}.1.bz2" $(echo "${i}" | sed -E 's@^qemu-([^\.]+)@qemu-\1-user-bin@; s@\.gz@\.bz2@'); \
		}; done
	} )
}
