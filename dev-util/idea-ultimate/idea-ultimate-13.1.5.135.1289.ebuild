# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
inherit eutils versionator

SLOT="$(get_major_version)"
RDEPEND=">=virtual/jdk-1.6"

PN1=${PN%-*}
PN2=${PN#*-}
PNS=${PN1:0:1}${PN2:0:1}

MY_PV="$(get_version_component_range 4-5)"
MY_PRE="$(get_version_component_range 6-6)"
MY_PRE=${MY_PRE/pre/}

RESTRICT="strip mirror"
QA_TEXTRELS="opt/${P}/bin/libbreakgen.so"

DESCRIPTION="IntelliJ IDEA is an intelligent Java IDE"
HOMEPAGE="http://jetbrains.com/idea/"

if [ -z $MY_PRE ]; then
	VER=($(get_all_version_components))
	if [[ "${VER[4]}" == "0" ]]; then
		if [[ "${VER[2]}" == "0" ]]; then
			SRC_URI="http://download.jetbrains.com/${PN1}/${PN1}${PNS^^}-$(get_version_component_range 1-1).tar.gz"
		else
			SRC_URI="http://download.jetbrains.com/${PN1}/${PN1}${PNS^^}-$(get_version_component_range 1-2).tar.gz"
		fi
	else
		SRC_URI="http://download.jetbrains.com/${PN1}/${PN1}${PNS^^}-$(get_version_component_range 1-3).tar.gz"
	fi
else
	SRC_URI="http://download.jetbrains.com/${PN1}/${PN1}${PNS^^}-${MY_PV}.tar.gz"
fi

LICENSE="IntelliJ-IDEA"
IUSE=""
KEYWORDS="~x86 ~amd64"
S="${WORKDIR}/${PN1}-${PNS^^}-${MY_PV}"

src_prepare() {
	epatch ${FILESDIR}/${PN}-${SLOT}.sh.patch || die
}

src_install() {
	local dir="/opt/${P}"
	local exe="${PN}-${SLOT}"
	newconfd "${FILESDIR}/config-${PN}-${SLOT}" ${PN}-${SLOT}
	# config files
	insinto "/etc/idea"
	mv bin/idea.properties bin/${PN}-${SLOT}.properties
	doins bin/${PN}-${SLOT}.properties
	rm bin/${PN}-${SLOT}.properties
	case $ARCH in
		amd64|ppc64)
			cat bin/idea64.vmoptions > bin/idea.vmoptions
			rm bin/idea64.vmoptions
			;;
	esac
	mv bin/idea.vmoptions bin/${PN}-${SLOT}.vmoptions
	doins bin/${PN}-${SLOT}.vmoptions
	rm bin/${PN}-${SLOT}.vmoptions
	ln -s /etc/idea/${PN}-${SLOT}.properties bin/idea.properties
	ln -s /etc/idea/${PN}-${SLOT}.vmoptions bin/idea.vmoptions
	# idea itself
	insinto "${dir}"
	doins -r *
	fperms 755 "${dir}/bin/${PN1}.sh"
	fperms 755 "${dir}/bin/fsnotifier"
	fperms 755 "${dir}/bin/fsnotifier64"
	newicon "bin/${PN1}.png" "${exe}.png"
	make_wrapper "${exe}" "/opt/${P}/bin/${PN1}.sh"
	make_desktop_entry ${exe} "IntelliJ IDEA ${PV}" "${exe}" "Development;IDE"
	# Protect idea conf on upgrade
	env_file="${T}/25${PN}-${SLOT}"
	echo "CONFIG_PROTECT=\"\${CONFIG_PROTECT} /etc/idea/conf\"" > "${env_file}"  || die
	doenvd "${env_file}"
}
