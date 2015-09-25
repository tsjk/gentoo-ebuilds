# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:

EAPI=5

inherit autotools eutils git-r3 flag-o-matic

DESCRIPTION="A Gtk based drop down terminal for Linux and Unix, similar to the consoles found in first person shooters"
HOMEPAGE="https://github.com/lanoxx/tilda/"
EGIT_REPO_URI="git://github.com/lanoxx/tilda.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="+vte290 vte291"
RESTRICT="mirror"

REQUIRED_USE="^^ ( vte290 vte291 )"

RDEPEND="dev-libs/confuse
	>=dev-libs/glib-2.30:2
	gnome-base/libglade
	x11-libs/gtk+:3
	vte290? ( x11-libs/vte:2.90 )
	vte291? ( x11-libs/vte:2.91 )"

DEPEND="${RDEPEND}
	virtual/pkgconfig"

DOCS="ABOUT-NLS AUTHORS COPYING ChangeLog HACKING.md NEWS README.md TODO.md"

src_prepare() {
	eautoreconf
}

src_configure() {
	econf $(use_enable vte291 'vte-2.91')
}
