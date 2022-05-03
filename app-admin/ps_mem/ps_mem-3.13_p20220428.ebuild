EAPI=7

PYTHON_COMPAT=( python3_{8,9,10} )
DISTUTILS_SINGLE_IMPL=1

inherit distutils-r1 vcs-snapshot

COMMIT="e3a6acc28d9c93fa2cebb4ddc0675328b4ec4908"

DESCRIPTION="A utility to report core memory usage per program"
HOMEPAGE="https://github.com/pixelb/ps_mem"
SRC_URI="https://github.com/pixelb/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~sparc ~x86"
IUSE=""
RESTRICT="mirror"

python_install() {
	distutils-r1_python_install --install-scripts="${EPREFIX}/usr/sbin"
}

python_install_all() {
	distutils-r1_python_install_all
	doman ${PN}.1
}
