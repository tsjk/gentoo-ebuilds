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
	local d

	for d in kitana kitana/data kitana/data/sessions kitana/static; do mkdir -p "${D}/var/lib/${d}"; done
        fowners nobody:nobody /var/lib/kitana /var/lib/kitana/data /var/lib/kitana/data/sessions /var/lib/kitana/static
        fperms 755 /var/lib/kitana /var/lib/kitana/data /var/lib/kitana/data/sessions /var/lib/kitana/static

	dodoc "${DOCS[@]}"; dodoc -r "deployment"
	for d in "${DOCS[@]}"; do rm -f "${S}/${d}"; done; rm -rf "${S}/deployment"

	mv "${S}/static"/* "${D}/var/lib/kitana/static"/; rmdir "${S}/static" || die; rm -rf "${S}/data"
        fowners -R nobody:nobody /var/lib/kitana/data /var/lib/kitana/static

	for d in kitana kitana/data kitana/data/sessions kitana/static; do keepdir /var/lib/${d}; done

	echo '# coding=utf-8' > "${S}/plugins/__init__.py"
	python_moduleinto ${PN}; python_domodule *
	ln -s $(realpath --relative-to="${D}/$(python_get_sitedir)/${PN}" "${D}/var/lib/kitana/data") "${D}/$(python_get_sitedir)/${PN}/data"
	ln -s $(realpath --relative-to="${D}/$(python_get_sitedir)/${PN}" "${D}/var/lib/kitana/static") "${D}/$(python_get_sitedir)/${PN}/static"
	python_optimize "${D}/$(python_get_sitedir)/${PN}"
	python_newexe "${PN}.py" "${PN}"
}
