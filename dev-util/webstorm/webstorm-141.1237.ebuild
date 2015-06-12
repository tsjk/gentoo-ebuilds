# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit user eutils

MY_PV="10.0.3"

DESCRIPTION="WebStorm is a lightweight yet powerful IDE, perfectly equipped for complex client-side development and server-side development with Node.js."
HOMEPAGE="https://www.jetbrains.com/webstorm"
SRC_URI="http://download-cf.jetbrains.com/webstorm/WebStorm-${MY_PV}.tar.gz"

LICENSE=""
SLOT="10"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=">=virtual/jre-1.6"
RDEPEND="${DEPEND}"

RESTRICT="mirror"

FOLDER="webstorm-${SLOT}"
PROGRAM_NAME="WebStorm ${SLOT}"

S="${WORKDIR}"

pkg_setup() {
	enewgroup webstorm
}

src_install() {
	dodir /opt/${FOLDER}

	cd WebStorm-*/
	insinto /opt/${FOLDER}
	doins -r *

	fowners -R :webstorm /opt/${FOLDER}/
	fperms -R g+w /opt/${FOLDER}/

	for i in webstorm.sh inspect.sh fsnotifier fsnotifier64; do
		fperms a+x /opt/${FOLDER}/bin/${i} || die "chmod of ${i} failed"
	done

	make_wrapper ${FOLDER} /opt/${FOLDER}/bin/webstorm.sh

	mv "bin/webide.png" "bin/${FOLDER}.png"
	doicon "bin/${FOLDER}.png"
	make_desktop_entry ${FOLDER} "${PROGRAM_NAME} (v${MY_PV}.${PV})" "${FOLDER}"
}

pkg_postinst() {
	elog
	elog "Users in the 'webstorm' group will be able to update the IDE with it's auto updater."
	elog
}
