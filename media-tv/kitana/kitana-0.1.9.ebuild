EAPI=7

PYTHON_COMPAT=( python{3_5,3_6,3_7} )
inherit python-single-r1 vcs-snapshot

COMMIT="aac2fd1e16817530de0d63baf2b500caf70c1ce4"
DESCRIPTION="A responsive Plex plugin web frontend"
HOMEPAGE="https://github.com/pannal/${PN}"
SRC_URI="https://github.com/pannal/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"
IUSE=""
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DOCS=('CHANGELOG' 'Dockerfile' 'Dockerfile.armhf' 'LICENSE' 'README.md')

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	>=dev-python/PyGithub-1.43.8[${PYTHON_USEDEP}]
	>=dev-python/cherrypy-18.3.0[${PYTHON_USEDEP}]
	>=dev-python/furl-2.1.0[${PYTHON_USEDEP}]
	>=dev-python/jinja-2.10.3[${PYTHON_USEDEP}]
	>=dev-python/libsass-0.19.3[${PYTHON_USEDEP}]
	>=dev-python/requests-2.22.0[${PYTHON_USEDEP}]
	>=dev-python/xmltodict-0.12.0[${PYTHON_USEDEP}]"


pkg_setup() {
	python-single-r1_pkg_setup
}

src_install() {
	dodoc "${DOCS[@]}"; dodoc -r "deployment"
	local d; for d in "${DOCS[@]}"; do rm -f "${S}/${d}"; done; rm -rf "${S}/deployment"
	python_moduleinto ${PN}
	python_domodule *
	rm -rf "${D}/$(python_get_sitedir)/${PN}/data"
	keepdir /var/lib/kitana
	keepdir /var/lib/kitana/sessions
        fowners nobody:nobody /var/lib/kitana /var/lib/kitana/sessions
        fperms 755 /var/lib/kitana /var/lib/kitana/sessions
	ln -s $(realpath --relative-to="${D}/$(python_get_sitedir)/${PN}" "${D}/var/lib/kitana") "${D}/$(python_get_sitedir)/${PN}/data"
	python_optimize "${D}/$(python_get_sitedir)/${PN}"
	python_newscript "${PN}.py" "${PN}"
}
