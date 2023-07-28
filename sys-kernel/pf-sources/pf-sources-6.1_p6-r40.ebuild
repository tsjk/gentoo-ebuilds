# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# Define what default functions to run.
ETYPE="sources"

# Use genpatches but don't include the 'experimental' use flag.
K_EXP_GENPATCHES_NOUSE="1"

# Genpatches version to use. -pf patch set already includes vanilla linux updates. Regularly "1"
# is the wanted value here, but the genpatches patch set can be bumped if it includes some
# important fixes. src_prepare() will handle deleting the updated vanilla linux patches.
K_GENPATCHES_VER="14"

# -pf patch set already sets EXTRAVERSION to kernel Makefile.
K_NOSETEXTRAVERSION="1"

# pf-sources is not officially supported/covered by the Gentoo security team.
K_SECURITY_UNSUPPORTED="1"

# Define which parts to use from genpatches - experimental is already included in the -pf patch
# set.
K_WANT_GENPATCHES="base extras"

# Major kernel version, e.g. 5.14.
SHPV="${PV/_p*/}"

# Replace "_p" with "-pf", since using "-pf" is not allowed for an ebuild name by PMS.
PFPV="${PV/_p/-pf}"

inherit kernel-2 optfeature
detect_version

DESCRIPTION="Linux kernel fork that includes the pf-kernel patchset and Gentoo's genpatches"
HOMEPAGE="https://pfkernel.natalenko.name/
	https://dev.gentoo.org/~mpagano/genpatches/"
for (( i=13; i <= "${PR#r}"; i++ )); do f="patch-6.1.$((i - 1))-${i}.xz"
	[[ -z "${INCR_FILES}" ]] || INCR_FILES+=" "; [[ -z "${INCR_URIS}" ]] || INCR_URIS+=" "
	INCR_FILES+="${f}"; INCR_URIS+="https://mirrors.edge.kernel.org/pub/linux/kernel/v6.x/incr/${f}"
done; unset i f
PATCHES=( "${FILESDIR}/0001-amd-pstate.patch" )
SRC_URI="https://codeberg.org/pf-kernel/linux/archive/v${PFPV}.tar.gz -> linux-${PFPV}.tar.gz
	https://dev.gentoo.org/~mpagano/genpatches/tarballs/genpatches-${SHPV}-${K_GENPATCHES_VER}.base.tar.xz
	https://dev.gentoo.org/~mpagano/genpatches/tarballs/genpatches-${SHPV}-${K_GENPATCHES_VER}.extras.tar.xz
	${INCR_URIS}"

KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"

S="${WORKDIR}/linux-${PFPV}-${PR}"

K_EXTRAEINFO="For more info on pf-sources and details on how to report problems,
	see: ${HOMEPAGE}."

pkg_setup() {
	ewarn ""
	ewarn "${PN} is *not* supported by the Gentoo Kernel Project in any way."
	ewarn "If you need support, please contact the pf developers directly."
	ewarn "Do *not* open bugs in Gentoo's bugzilla unless you have issues with"
	ewarn "the ebuilds. Thank you."
	ewarn ""

	kernel-2_pkg_setup
}

src_unpack() {
	# Since the Codeberg-hosted pf-sources include full kernel sources, we need to manually override
	# the src_unpack phase because kernel-2_src_unpack() does a lot of unwanted magic here.
	unpack ${A}

	mv linux linux-${PFPV}-${PR} || die "Failed to move source directory"
}

src_prepare() {
	# When genpatches basic version is bumped, it also includes vanilla linux updates. Those are
	# already in the -pf patch set, so need to remove the vanilla linux patches to avoid conflicts.
	if [[ ${K_GENPATCHES_VER} -ne 1 ]]; then
		find "${WORKDIR}"/ -type f -name '10*linux*patch' -delete ||
			die "Failed to delete vanilla linux patches in src_prepare."
	fi

	# kernel-2_src_prepare doesn't apply PATCHES(). Chosen genpatches are also applied here.
	eapply "${WORKDIR}"/*.patch

	local i
	local _EXPECTED_REJECTS=(
		"Makefile.rej:26f0fad2e113f92cd0b822545daf67c83ca65cc917d4cb6d3a18b9532fbe55da8c5d5cc68fd4429a97431c8e2ee472843b6bfe9c8d18f8601abf45e0a0eddf6e"
		"scripts/gcc-plugins/Makefile.rej:e99789de72c68cbcf00fa3b9b01f943e18056fb91b5263292d5c1a9e2c167ef8d16620aef9c9b856a53885f598b6fa63f07ce6ec607ed43a18000727ff44b26d"
		"drivers/cpufreq/amd-pstate.c.rej:da986d13b2aa985d8fa41a73b5c551ff781aae7d7434fdc6e31411f129b08db06d3d848c7301a59588df567f81065a143dd6934b305464d69a6fda0760632f4e"
		"drivers/cpufreq/davinci-cpufreq.c.rej:575071b8a491e881c94c06827095e82c62036b32274f49c041bf1ee8aed58b7e300c439a2f2b13ee44070af4cffa35478e006892a7523a1ac3e3962879432b14"
		"drivers/char/tpm/tpm.h.rej:b15ff615ccb99311e9fb8db0a11ff832aad565d9b115dc3658355e9a24ca825f307a85e09103ec54fc4383ff24ecaca284e3dfd096b674d3d88e6e259abd992c"
		"drivers/char/tpm/tpm-chip.c.rej:3ecf3bfe68b8d69691fea08541c373a10a878bfcb8dcfc5d45290eeda207048d1073fc55015df625abf796cacada0a97061a2c3111832df0ab0f77c225a7d169"
	)
	for i in ${INCR_FILES}; do
		echo "Applying \"${i}\"..."
		( cd "${S}" && xzcat "${DISTDIR}"/"${i}" | patch -Nsp1 | \
		  egrep -v '^[0-9]+ out of [0-9]+ hunks? FAILED -- saving rejects to file Makefile\.rej$|^[0-9]+ out of [0-9]+ hunk ignored -- saving rejects to file |Skipping patch\.$' )
		echo "Applied \"${i}\"..."; done

	( cd "${S}" && sed -i -e "s:^\(SUBLEVEL =\).*:\1 ${K_SUBLEVEL}:" Makefile )
	( cd "${S}" && for i in "${_EXPECTED_REJECTS[@]}"; do
		[[ "$(sha512sum "${i%:*}" | awk '{ print $1 }')" == "${i#*:}" ]] && rm -f "${i%:*}"; done )
	[[ -z $(find "${S}" -name '*.rej' 2> /dev/null) ]] || \
		{ echo "Unexpected rejects:"; find "${S}" -name '*.rej' 2> /dev/null; die "Unexpected rejects found!"; }

	sed -i -E 's@^SUBLEVEL\s*=\s*$@SUBLEVEL = 0@' "${S}/Makefile" || die "Failed to set SUBLEVEL!"

	default
}

pkg_postinst() {
	# Fixes "wrongly" detected directory name, bgo#862534.
	local KV_FULL="${PFPV}-${PR}"
	kernel-2_pkg_postinst

	optfeature "userspace KSM helper" sys-process/uksmd
}

pkg_postrm() {
	# Same here, bgo#862534.
	local KV_FULL="${PFPV}-${PR}"
	kernel-2_pkg_postrm
}
