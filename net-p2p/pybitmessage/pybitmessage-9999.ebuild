# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 )

# See https://github.com/Bitmessage/PyBitmessage/pull/952 for
# why ipv6 is needed at the moment.
PYTHON_REQ_USE="ipv6,sqlite"

inherit distutils-r1 gnome2-utils git-r3

MY_PN="PyBitmessage"


DESCRIPTION="Reference client for Bitmessage: a P2P communications protocol"
HOMEPAGE="https://bitmessage.org/"
EGIT_REPO_URI="https://github.com/Bitmessage/PyBitmessage.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE="libressl ncurses opencl qt4 sound"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="${PYTHON_DEPS}"

# Some of these can be determined from src/depends.py.
# The sound deps were found in src/bitmessageqt/__init__.py.
# And src/openclpow.py imports numpy directly, so throw that in too.
#
# All of the dependencies that are behind USE flags are detected
# and enabled automagically, so maybe it would be better if we
# required them unconditionally?
RDEPEND="${DEPEND}
	dev-python/msgpack[${PYTHON_USEDEP}]
	!libressl? ( dev-libs/openssl:0[-bindist] )
	libressl? ( dev-libs/libressl )
	ncurses? ( dev-python/pythondialog[${PYTHON_USEDEP}] )
	opencl? (
		dev-python/numpy[${PYTHON_USEDEP}]
		dev-python/pyopencl[${PYTHON_USEDEP}]
	)
	qt4? ( dev-python/PyQt4[${PYTHON_USEDEP}] )
	sound? (
		media-sound/alsa-utils
		media-sound/gst123
		media-sound/mpg123
	)"

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

	use qt4 || rm -rf src/bitmessageqt
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

	if use qt4; then
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
