EAPI=7

PYTHON_COMPAT=( python{3_5,3_6,3_7} )
DISTUTILS_SINGLE_IMPL=1
inherit distutils-r1 vcs-snapshot

COMMIT="aac2fd1e16817530de0d63baf2b500caf70c1ce4"

DESCRIPTION="A responsive Plex plugin web frontend"
HOMEPAGE="https://github.com/pannal/${PN}"
SRC_URI="https://github.com/pannal/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"
IUSE=""

DOCS=('CHANGELOG' 'Dockerfile' 'LICENCE' 'README.md')

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	>=dev-python/PyGithub-1.43.8[${PYTHON_USEDEP}]
	>=dev-python/cherrypy-18.3.0[${PYTHON_USEDEP}]
	>=dev-python/furl-2.1.0[${PYTHON_USEDEP}]
	>=dev-python/jinja-2.10.3[${PYTHON_USEDEP}]
	>=dev-python/libsass-0.19.3[${PYTHON_USEDEP}]
	>=dev-python/requests-2.22.0[${PYTHON_USEDEP}]
	>=dev-python/xmltodict-0.12.0[${PYTHON_USEDEP}]"

python_install() {
	distutils-r1_python_install --install-scripts="${EPREFIX}/usr/sbin"
}

python_install_all() {
	distutils-r1_python_install_all
}
