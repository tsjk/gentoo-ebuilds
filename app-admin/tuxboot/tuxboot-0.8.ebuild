# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils qt4-r2

DESCRIPTION="Tuxboot helps you to create a bootable Live USB drive for Clonezilla live, DRBL live, GParted live and Tux2live."
HOMEPAGE="http://tuxboot.org"
SRC_URI="mirror://sourceforge/tuxboot/${PF}.src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
DEPEND="app-arch/p7zip
	dev-qt/qtcore:4
	dev-qt/qtgui:4
	sys-auth/polkit-qt
	sys-boot/syslinux
	sys-fs/mtools"
RDEPEND="${DEPEND}"

src_prepare() {
	qt4-r2_src_prepare
	sed -i 's/0.7/0.8/' version.h
	sed -i '/\[en_US\]/d' ${PN}.desktop
	sed -i '/^RESOURCES/d' ${PN}.pro
	/usr/lib64/qt4/bin/lupdate ${PN}.pro
	/usr/lib64/qt4/bin/lrelease ${PN}.pro
}

src_configure() {
   eqmake4 "DEFINES += NOSTATIC" "RESOURCES -= tuxboot.qrc"
}

src_install() {
	dobin tuxboot
	dodoc ChangeLog README.TXT
	doicon ${PN}.xpm
	make_desktop_entry ${PN} ${PN} ${PN} "System;"
}
