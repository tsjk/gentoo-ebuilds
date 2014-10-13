# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3} )
inherit cmake-utils git-r3 python-any-r1

DESCRIPTION="Off-The-Record messaging (OTR) for irssi"
HOMEPAGE="http://irssi-otr.tuxfamily.org"
EGIT_REPO_URI="git://git.tuxfamily.org/gitroot/irssiotr/irssiotr.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="debug"

RDEPEND=">=net-libs/libotr-3.1.0
	dev-libs/glib:2
	dev-libs/libgcrypt:0
	dev-libs/libgpg-error
	net-irc/irssi"

DEPEND="${PYTHON_DEPS}
	${RDEPEND}
	virtual/pkgconfig"

DOCS=( ChangeLog LICENSE README README.irssi-headers README.xchat )

src_prepare() {
	cmake-utils_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DDOCDIR="/usr/share/doc/${PF}"
	)
	cmake-utils_src_configure
}
