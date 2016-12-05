# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="6"

inherit cmake-utils git-r3 toolchain-funcs

DESCRIPTION="FiSH blowfish encryption irssi module"
HOMEPAGE="https://github.com/falsovsky/FiSH-irssi"
EGIT_REPO_URI="https://github.com/falsovsky/FiSH-irssi.git"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
DEPEND="	dev-libs/glib:2
		dev-libs/openssl:0
		net-irc/irssi"
RDEPEND="net-irc/irssi"
DOCS=( README README.md )

#src_prepare() {
#	local mycmakeargs=(
#		-DDOCDIR="/usr/share/doc/${PF}"
#	)
#	cmake-utils_src_configure
#}

#src_install() {
#	insinto /usr/$(get_libdir)/irssi/modules
#	doins libfish.so || die "install failed"
#}
