# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit eutils versionator

DESCRIPTION="Free calls, text and picture sharing with anyone, anywhere!"
HOMEPAGE="http://www.viber.com"
SRC_URI="http://download.cdn.viber.com/cdn/desktop/Linux/viber.deb"

SLOT="0"
KEYWORDS="~amd64"
IUSE=""
RESTRICT="mirror"

src_unpack() {
	unpack ${A}
	mkdir ${P}
}

src_prepare(){
	tar -xf "${WORKDIR}/data.tar.gz" -C "${S}"
}

src_install(){
	cp -a "${S}"/* "${D}"/ || die

	fowners -R root:root "/opt"
	fowners -R root:root "/usr"
        find "${D}/" -type d -print0 | xargs -0 chmod 0755
        find "${D}/" -type f -perm /111 -print0 | xargs -0 chmod 0755
        find "${D}/" -type f ! -perm /111 -print0 | xargs -0 chmod 0644
	fperms 0777 "/usr/share/${PN}"

        make_wrapper "${PN}" "/opt/viber/${PN}/Viber"
}

pkg_prerm(){
	[[ -e "${ROOT}usr/share/${PN}/launcher.db" ]] && rm -rf "${ROOT}usr/share/${PN}/launcher.db"
}
