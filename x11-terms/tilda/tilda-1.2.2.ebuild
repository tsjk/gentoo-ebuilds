# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:

EAPI=5

inherit autotools eutils

DESCRIPTION="A Gtk based drop down terminal for Linux and Unix, similar to the consoles found in first person shooters"
HOMEPAGE="https://github.com/lanoxx/tilda/"
SRC_URI="https://github.com/lanoxx/${PN}/archive/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~x86-fbsd ~x86-interix ~amd64-linux ~x86-linux"
IUSE=""
RESTRICT="mirror"

RDEPEND="dev-libs/confuse
	>=dev-libs/glib-2.30:2
	gnome-base/libglade
	x11-libs/gtk+:3
	x11-libs/vte:2.90"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

S="${WORKDIR}/${PN}-${P}"

DOCS="ABOUT-NLS AUTHORS COPYING ChangeLog HACKING.md NEWS README.md TODO.md"

src_prepare() {
	eautoreconf
}
