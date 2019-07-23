# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="5"
inherit readme.gentoo toolchain-funcs eapi7-ver

KEYWORDS="-* ~amd64 ~ppc ~ppc64 ~x86"
HOMEPAGE="https://pfactum.github.io/pf-kernel/"
IUSE=""

PF_FILE="patch-${PV/_p*/}-pf${PV/*_p/}.diff"
PF_URI="https://github.com/pfactum/pf-kernel/compare/v${PV/_p*/}...v${PV/_p*/}-pf${PV/*_p/}.diff"

K_SUBLEVEL="${PR#r}"
INCR_FILES="patch-4.19.12-13.xz patch-4.19.13-14.xz patch-4.19.14-15.xz patch-4.19.15-16.xz patch-4.19.16-17.xz patch-4.19.17-18.xz patch-4.19.18-19.xz patch-4.19.19-20.xz patch-4.19.20-21.xz patch-4.19.21-22.xz patch-4.19.22-23.xz patch-4.19.23-24.xz patch-4.19.24-25.xz patch-4.19.25-26.xz patch-4.19.26-27.xz patch-4.19.27-28.xz patch-4.19.28-29.xz patch-4.19.29-30.xz patch-4.19.30-31.xz patch-4.19.31-32.xz patch-4.19.32-33.xz patch-4.19.33-34.xz patch-4.19.34-35.xz patch-4.19.35-36.xz patch-4.19.36-37.xz patch-4.19.37-38.xz patch-4.19.38-39.xz patch-4.19.39-40.xz patch-4.19.40-41.xz patch-4.19.41-42.xz patch-4.19.42-43.xz patch-4.19.43-44.xz patch-4.19.44-45.xz patch-4.19.45-46.xz patch-4.19.46-47.xz patch-4.19.47-48.xz patch-4.19.48-49.xz patch-4.19.49-50.xz patch-4.19.50-51.xz patch-4.19.51-52.xz patch-4.19.52-53.xz patch-4.19.53-54.xz patch-4.19.54-55.xz patch-4.19.55-56.xz patch-4.19.56-57.xz patch-4.19.57-58.xz patch-4.19.58-59.xz patch-4.19.59-60.xz"
INCR_URIS="https://www.kernel.org/pub/linux/kernel/v4.x/incr/patch-4.19.12-13.xz https://www.kernel.org/pub/linux/kernel/v4.x/incr/patch-4.19.13-14.xz https://www.kernel.org/pub/linux/kernel/v4.x/incr/patch-4.19.14-15.xz https://www.kernel.org/pub/linux/kernel/v4.x/incr/patch-4.19.15-16.xz https://www.kernel.org/pub/linux/kernel/v4.x/incr/patch-4.19.16-17.xz https://www.kernel.org/pub/linux/kernel/v4.x/incr/patch-4.19.17-18.xz https://www.kernel.org/pub/linux/kernel/v4.x/incr/patch-4.19.18-19.xz https://www.kernel.org/pub/linux/kernel/v4.x/incr/patch-4.19.19-20.xz https://www.kernel.org/pub/linux/kernel/v4.x/incr/patch-4.19.20-21.xz https://www.kernel.org/pub/linux/kernel/v4.x/incr/patch-4.19.21-22.xz https://www.kernel.org/pub/linux/kernel/v4.x/incr/patch-4.19.22-23.xz https://www.kernel.org/pub/linux/kernel/v4.x/incr/patch-4.19.23-24.xz https://www.kernel.org/pub/linux/kernel/v4.x/incr/patch-4.19.24-25.xz https://www.kernel.org/pub/linux/kernel/v4.x/incr/patch-4.19.25-26.xz https://www.kernel.org/pub/linux/kernel/v4.x/incr/patch-4.19.26-27.xz https://www.kernel.org/pub/linux/kernel/v4.x/incr/patch-4.19.27-28.xz https://www.kernel.org/pub/linux/kernel/v4.x/incr/patch-4.19.28-29.xz https://www.kernel.org/pub/linux/kernel/v4.x/incr/patch-4.19.29-30.xz https://www.kernel.org/pub/linux/kernel/v4.x/incr/patch-4.19.30-31.xz https://www.kernel.org/pub/linux/kernel/v4.x/incr/patch-4.19.31-32.xz https://www.kernel.org/pub/linux/kernel/v4.x/incr/patch-4.19.32-33.xz https://www.kernel.org/pub/linux/kernel/v4.x/incr/patch-4.19.33-34.xz https://www.kernel.org/pub/linux/kernel/v4.x/incr/patch-4.19.34-35.xz https://www.kernel.org/pub/linux/kernel/v4.x/incr/patch-4.19.35-36.xz https://www.kernel.org/pub/linux/kernel/v4.x/incr/patch-4.19.36-37.xz https://www.kernel.org/pub/linux/kernel/v4.x/incr/patch-4.19.37-38.xz https://www.kernel.org/pub/linux/kernel/v4.x/incr/patch-4.19.38-39.xz https://www.kernel.org/pub/linux/kernel/v4.x/incr/patch-4.19.39-40.xz https://www.kernel.org/pub/linux/kernel/v4.x/incr/patch-4.19.40-41.xz https://www.kernel.org/pub/linux/kernel/v4.x/incr/patch-4.19.41-42.xz https://www.kernel.org/pub/linux/kernel/v4.x/incr/patch-4.19.42-43.xz https://www.kernel.org/pub/linux/kernel/v4.x/incr/patch-4.19.43-44.xz https://www.kernel.org/pub/linux/kernel/v4.x/incr/patch-4.19.44-45.xz https://www.kernel.org/pub/linux/kernel/v4.x/incr/patch-4.19.45-46.xz https://www.kernel.org/pub/linux/kernel/v4.x/incr/patch-4.19.46-47.xz https://www.kernel.org/pub/linux/kernel/v4.x/incr/patch-4.19.47-48.xz https://www.kernel.org/pub/linux/kernel/v4.x/incr/patch-4.19.48-49.xz https://www.kernel.org/pub/linux/kernel/v4.x/incr/patch-4.19.49-50.xz https://www.kernel.org/pub/linux/kernel/v4.x/incr/patch-4.19.50-51.xz https://www.kernel.org/pub/linux/kernel/v4.x/incr/patch-4.19.51-52.xz https://www.kernel.org/pub/linux/kernel/v4.x/incr/patch-4.19.52-53.xz https://www.kernel.org/pub/linux/kernel/v4.x/incr/patch-4.19.53-54.xz https://www.kernel.org/pub/linux/kernel/v4.x/incr/patch-4.19.54-55.xz https://www.kernel.org/pub/linux/kernel/v4.x/incr/patch-4.19.55-56.xz https://www.kernel.org/pub/linux/kernel/v4.x/incr/patch-4.19.56-57.xz https://www.kernel.org/pub/linux/kernel/v4.x/incr/patch-4.19.57-58.xz https://www.kernel.org/pub/linux/kernel/v4.x/incr/patch-4.19.58-59.xz https://www.kernel.org/pub/linux/kernel/v4.x/incr/patch-4.19.59-60.xz"
PATCHES="${FILESDIR}/0001-sysctl.patch ${FILESDIR}/0002-mmap.patch"

COMPRESSTYPE=".xz"

CKV="$(ver_cut 1-2)"
ETYPE="sources"
K_NOSETEXTRAVERSION="1"
K_PREPATCHED="1"
K_SECURITY_UNSUPPORTED="1"

inherit kernel-2

UNIPATCH_STRICTORDER="yes"
UNIPATCH_LIST_DEFAULT="${DISTDIR}/${PF_FILE}"

detect_version

DESCRIPTION="Linux kernel fork with new features, including the -ck patchset (BFS), BFQ"
SRC_URI="${KERNEL_URI} ${GENPATCHES_URI} ${INCR_URIS} ${PF_URI} -> ${PF_FILE}"

KV_FULL="${PVR}-pf"
S="${WORKDIR}"/linux-"${KV_FULL}"

DISABLE_AUTOFORMATTING="yes"
DOC_CONTENTS="
${P} has the following optional runtime dependencies:
- sys-apps/tuxonice-userui: provides minimal userspace progress
information related to suspending and resuming process.
- sys-power/hibernate-script or sys-power/pm-utils: runtime utilities
for hibernating and suspending your computer."

pkg_pretend() {
	# 547868
	if [[ $(gcc-version) < 4.9 ]]; then
			eerror ""
			eerror "${P} needs an active GCC 4.9+ compiler"
			eerror ""
			die "${P} needs an active sys-devel/gcc >= 4.9"
	fi
}

pkg_setup(){
	ewarn
	ewarn "${PN} is *not* supported by the Gentoo Kernel Project in any way."
	ewarn "If you need support, please contact the pf developers directly."
	ewarn "Do *not* open bugs in Gentoo's bugzilla unless you have issues with"
	ewarn "the ebuilds. Thank you."
	ewarn
	kernel-2_pkg_setup
}

src_prepare() {
	local _EXPECTED_REJECTS=( 	'Makefile.rej' \
					'drivers/memstick/core/memstick.c.rej' \
					'fs/cifs/smb2pdu.c.rej' \
					'kernel/sysctl.c.rej' \
					'mm/mmap.c.rej' )
	for i in ${INCR_FILES}; do
		( cd "${S}" && xzcat "${DISTDIR}"/"${i}" | patch -Nsp1 | \
		  egrep -v 'Makefile\.rej$|Skipping\ patch.$|\ hunks\ ignored\ --\ saving\ rejects\ to\ file\ ' ); done
	for i in ${PATCHES}; do ( cd "${S}" && patch -Np1 -i "${i}"); done

	( cd "${S}" && sed -i -e "s:^\(SUBLEVEL =\).*:\1 ${K_SUBLEVEL}:" Makefile )
	( cd "${S}" && for i in "${_EXPECTED_REJECTS[@]}"; do rm -f "${i}"; done )
	[[ -z $(find "${S}" -name '*.rej' 2> /dev/null) ]] || \
		{ echo "Unexpected rejects:"; find "${S}" -name '*.rej' 2> /dev/null; die "Unexpected rejects found!"; }
}

src_install() {
	kernel-2_src_install
	readme.gentoo_create_doc
}

pkg_postinst() {
	kernel-2_pkg_postinst
	readme.gentoo_print_elog
}

K_EXTRAEINFO="For more info on pf-sources and details on how to report problems,
see: ${HOMEPAGE}."
