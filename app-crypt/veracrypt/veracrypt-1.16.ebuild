# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit unpacker

# Major version

DESCRIPTION="VeraCrypt is a free disk encryption software based on TrueCrypt"
HOMEPAGE="https://veracrypt.codeplex.com"
SRC_URI="https://github.com/veracrypt/VeraCrypt/archive/VeraCrypt_${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="truecrypt-3.0"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~amd64-fbsd ~arm ~arm64 ~hppa ~ia64 ~m68k ~mips ~nios2 ~ppc ~ppc64 ~s390 ~sh ~sparc ~sparc-fbsd ~x86 ~x86-fbsd"
IUSE=""

RESTRICT="mirror"

DEPEND="app-arch/makeself
	dev-lang/nasm
	dev-ruby/pkg-config
	sys-devel/base-gcc
	>=sys-devel/gcc-4.9.2
	sys-devel/make
	sys-fs/fuse
"

RDEPEND="${DEPEND}"

S=${WORKDIR}

src_unpack() {
	unpack ${A} || die "Could not unpack!"
	mv ${WORKDIR}/* ${WORKDIR}/${PN} || die "Could not move source directory!"
	return
}

src_prepare() {
	WX_WIDGETS_VERSION="3.0.2"
	wget -O ${WORKDIR}/wxWidgets-${WX_WIDGETS_VERSION}.tar.bz2 https://sourceforge.net/projects/wxwindows/files/${WX_WIDGETS_VERSION}/wxWidgets-${WX_WIDGETS_VERSION}.tar.bz2 || die "Could no download wxWidgets"
	mkdir -p ${WORKDIR}/wxrelease || die "Could not make directory wxrelease!"
	tar xjf /${WORKDIR}/wxWidgets-${WX_WIDGETS_VERSION}.tar.bz2 -C ${WORKDIR}/wxrelease --strip-component 1 || die "Could not untar wxWidgets!"
	return
}

src_compile() {
	cd ${WORKDIR}/${PN}/src
	make WXSTATIC=1 WX_ROOT=${WORKDIR}/wxrelease wxbuild || die "Could not make wxWidgets!"
	make WXSTATIC=1 || die "Could not make VeraCrypt!"
	return
}

src_install() {
	exeinto /usr/bin
	doexe ${WORKDIR}/${PN}/src/Main/veracrypt || die "Could not create veracrypt executable!"
	insinto /usr/share/pixmaps
	doins "${FILESDIR}"/veracrypt.png || die "Could not copy veracrypt.png"
	return
}

pkg_postinst() {
	xdg-desktop-menu install "${FILESDIR}"/abadonna-veracrypt.desktop || die "Could not register a menu item!"
	return
}

pkg_postrm() {
	xdg-desktop-menu uninstall "${FILESDIR}"/abadonna-veracrypt.desktop || die "Could not de-register a menu item!"
	return
}
