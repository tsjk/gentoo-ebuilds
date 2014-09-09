# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit eutils user versionator

DESCRIPTION="The High Velocity Web Framework For Java and Scala"
HOMEPAGE="http://www.playframework.com/"

SRC_URI="http://downloads.typesafe.com/${PN}/${PV}/${P}.zip"

LICENSE="Apache-2.0"
KEYWORDS="amd64 ppc ppc64 x86 ~x86-fbsd ~amd64-linux ~x86-linux ~x86-macos"
SLOT="$(get_version_component_range 1-2)"
IUSE=""
RESTRICT="mirror"

DEPEND=">=virtual/jdk-1.6
       "

RDEPEND=">=virtual/jre-1.6
        "

pkg_setup() {
        enewgroup playdevelopers
}

src_install() {
        local dir="/opt/${P}"
        insinto "${dir}"
        doins -r *

	fowners -R root:playdevelopers "${dir}"
        find "${ED}/${dir}/" -type d -print0 | xargs -0 chmod 0770
	find "${ED}/${dir}/" -type f -perm /111 -print0 | xargs -0 chmod 0770
        find "${ED}/${dir}/" -type f ! -perm /111 -print0 | xargs -0 chmod 0660

        make_wrapper "${P}" "${dir}/${PN}"
        elog "You must be in the playdevelopers group to use Play2 framework."
}
