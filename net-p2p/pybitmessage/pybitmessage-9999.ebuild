# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 )
PYTHON_REQ_USE="sqlite"

COMMIT=30e211367003bafa67834ffff3f31e6b5a897f4b
inherit distutils-r1 gnome2-utils git-r3

MY_PN="PyBitmessage"

DESCRIPTION="Reference client for Bitmessage: a P2P communications protocol"
HOMEPAGE="https://bitmessage.org"
#SRC_URI="https://github.com/g1itch/${MY_PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
EGIT_REPO_URI="https://github.com/Bitmessage/PyBitmessage.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug libnotify libressl ncurses opencl qrcode qt5 sound"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="${PYTHON_DEPS}"

RDEPEND="${DEPEND}
	|| (
		dev-python/msgpack[${PYTHON_USEDEP}]
		dev-python/u-msgpack[${PYTHON_USEDEP}]
	)
	dev-python/PyQt5[${PYTHON_USEDEP}]
	>=dev-python/QtPy-1.3.1[gui,pyqt5(+),${PYTHON_USEDEP}]
	debug? ( dev-python/python-prctl[${PYTHON_USEDEP}] )
	libnotify? (
		dev-python/pygobject[${PYTHON_USEDEP}]
		dev-python/notify2[${PYTHON_USEDEP}]
		x11-themes/hicolor-icon-theme
	)
	!libressl? ( dev-libs/openssl:0[-bindist] )
	libressl? ( dev-libs/libressl )
	ncurses? ( dev-python/pythondialog[${PYTHON_USEDEP}] )
	opencl? (
		dev-python/numpy[${PYTHON_USEDEP}]
		dev-python/pyopencl[${PYTHON_USEDEP}]
	)
	qrcode? ( dev-python/qrcode[${PYTHON_USEDEP}] )
	sound? ( || (
		dev-python/gst-python:1.0[${PYTHON_USEDEP}]
		media-sound/gst123
		media-libs/gst-plugins-base:1.0
		media-sound/mpg123
		media-sound/alsa-utils
	) )
"

src_compile() { :; }

src_install () {
	cat >> "${T}"/${PN}-wrapper <<-EOF || die
	#!/usr/bin/env python
	import os
	import sys
	sys.path.append("@SITEDIR@")
	os.chdir("@SITEDIR@")
	os.execl('@PYTHON@', '@EPYTHON@', '@SITEDIR@/bitmessagemain.py')
	EOF

	use qt5 || rm -rf src/bitmessageqt
	use ncurses || rm -rf src/bitmessagecurses
	touch src/__init__.py || die

	install_python() {
		python_moduleinto ${PN}
		python_domodule src/*
		sed \
			-e "s#@SITEDIR@#$(python_get_sitedir)/${PN}#" \
			-e "s#@EPYTHON@#${EPYTHON}#" \
			-e "s#@PYTHON@#${PYTHON}#" \
			"${T}"/${PN}-wrapper > ${PN} || die
		python_doscript ${PN}
	}

	python_foreach_impl install_python

	dodoc README.md
	doman man/*

	if use qt5; then
		newicon -s 24 desktop/icon24.png ${PN}.png
		newicon -s scalable desktop/can-icon.svg ${PN}.svg
		domenu desktop/${PN}.desktop
	fi
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}
