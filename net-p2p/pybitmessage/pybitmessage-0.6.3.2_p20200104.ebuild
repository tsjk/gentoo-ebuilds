EAPI=6

PYTHON_COMPAT=( python2_7 )
PYTHON_REQ_USE="sqlite"

COMMIT=61f64f72c36b315ef8663176d6cc2474af4457ea
inherit distutils-r1 gnome2-utils

MY_PN="PyBitmessage"

DESCRIPTION="Reference client for Bitmessage: a P2P communications protocol"
HOMEPAGE="https://bitmessage.org"
SRC_URI="https://github.com/g1itch/${MY_PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug libnotify libressl ncurses opencl pyqt qrcode sound"
REQUIRED_USE="${PYTHON_REQUIRED_USE}
		|| ( ncurses pyqt )"

DEPEND="${PYTHON_DEPS}"

RDEPEND="${DEPEND}
	|| (
		dev-python/msgpack[${PYTHON_USEDEP}]
		dev-python/u-msgpack[${PYTHON_USEDEP}]
	)
	pyqt? (
		dev-python/PyQt5[${PYTHON_USEDEP}]
		>=dev-python/QtPy-1.9.0[gui,pyqt5(+),${PYTHON_USEDEP}]
	)
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

S="${WORKDIR}"/${MY_PN}-${COMMIT}

src_install () {
	distutils-r1_src_install
	einstalldocs
	# The man page is not installed because it's basically empty.
}

pkg_postinst() {
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}
