# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/uzbl/uzbl-9999.ebuild,v 1.26 2012/08/20 17:12:46 radhermit Exp $

EAPI="5"

inherit eutils

IUSE="gtk3"
if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI=${EGIT_REPO_URI:-"git://github.com/Dieterbe/uzbl.git"}
	KEYWORDS=""
	SRC_URI=""
	EGIT_BRANCH="next"
	EGIT_COMMIT="next"
else
	inherit vcs-snapshot
	KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
	SRC_URI="http://github.com/Dieterbe/${PN}/tarball/${PV} -> ${P}.tar.gz"
fi

DESCRIPTION="Web interface tools which adhere to the unix philosophy."
HOMEPAGE="http://www.uzbl.org"

LICENSE="LGPL-2.1 MPL-1.1"
SLOT="0"
IUSE+=" +browser helpers +tabbed vim-syntax"

REQUIRED_USE="tabbed? ( browser )"

COMMON_DEPEND="
	dev-libs/glib:2
	>=dev-libs/icu-4.0.1
	>=net-libs/libsoup-2.24:2.4
	!gtk3? (
		>=net-libs/webkit-gtk-1.1.15:2
		>=x11-libs/gtk+-2.14:2
	)
	gtk3? (
		net-libs/webkit-gtk:3
		x11-libs/gtk+:3
	)

"

DEPEND="
	virtual/pkgconfig
	${COMMON_DEPEND}
"

RDEPEND="
	${COMMON_DEPEND}
	x11-misc/xdg-utils
	browser? (
		x11-misc/xclip
	)
	helpers? (
		dev-python/pygtk
		dev-python/pygobject:2
		gnome-extra/zenity
		net-misc/socat
		x11-libs/pango
		x11-misc/dmenu
		x11-misc/xclip
	)
	tabbed? (
		dev-python/pygtk
	)
	vim-syntax? ( || ( app-editors/vim app-editors/gvim ) )
"
# TODO document what requires the above helpers

pkg_setup() {
	if ! use helpers; then
		elog "uzbl's extra scripts use various optional applications:"
		elog
		elog "   dev-python/pygtk"
		elog "   dev-python/pygobject:2"
		elog "   gnome-extra/zenity"
		elog "   net-misc/socat"
		elog "   x11-libs/pango"
		elog "   x11-misc/dmenu"
		elog "   x11-misc/xclip"
		elog
		elog "Make sure you emerge the ones you need manually."
		elog "You may also activate the *helpers* USE flag to"
		elog "install all of them automatically."
	else
		einfo "You have enabled the *helpers* USE flag that installs"
		einfo "various optional applications used by uzbl's extra scripts."
	fi
}

src_prepare() {
	epatch_user

	# remove -ggdb
	sed -i "s/-ggdb //g" Makefile ||
		die "-ggdb removal sed failed"

	# fix DESTDIR support
	sed -i "s@setup.py install --prefix=\$(PREFIX) --root=\$(DESTDIR)@setup.py install --prefix=\$(DESTDIR)/\$(PREFIX)@" Makefile ||
		die "Makefile sed for install faled"

	# pygtk is python2-only
	sed -i "s:#!/usr/bin/env python:#!/usr/bin/env python2:" bin/uzbl-tabbed ||
		die "uzbl-tabbed python2 sed failed"
}

src_compile() {
	emake ENABLE_GTK3=$(use gtk3 && echo yes || echo no)
}

src_install() {
	local targets="install-uzbl-core"
	use browser && targets="${targets} install-uzbl-browser"
	use browser && use tabbed && targets="${targets} install-uzbl-tabbed"

	mkdir -m0755 -p "${D}/usr/share/man/man1"
	mkdir -m0755 -p "${D}/usr/share/appdata"
	emake DESTDIR="${D}" PREFIX="${EPREFIX}/usr" DOCDIR="${ED}/usr/share/doc/${PF}" ${targets}

	if use vim-syntax; then
		insinto /usr/share/vim/vimfiles/ftdetect
		doins "${S}"/extras/vim/ftdetect/uzbl.vim

		insinto /usr/share/vim/vimfiles/syntax
		doins "${S}"/extras/vim/syntax/uzbl.vim
	fi

}
