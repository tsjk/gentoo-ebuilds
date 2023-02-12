EAPI=8

PYTHON_COMPAT=( python3_{9,10} )
DISTUTILS_USE_PEP517=setuptools

DESCRIPTION="Gajim plugin for OMEMO XMPP end-to-end encryption"
HOMEPAGE="https://dev.gajim.org/gajim/gajim-plugins/wikis/OmemoGajimPlugin"

MY_PN="omemo"

if [[ "${PV}" = "9999" ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://dev.gajim.org/gajim/gajim-plugins.git"
	KEYWORDS=""
else
	SRC_URI="https://ftp.gajim.org/plugins_releases/${MY_PN}_${PV}.zip"
	KEYWORDS="~amd64"
fi

inherit python-r1

LICENSE="GPL-3"
SLOT="0"
RESTRICT="mirror"

S="${WORKDIR}"

RDEPEND="
	${PYTHON_DEPS}
	net-im/gajim
	dev-python/python-axolotl[${PYTHON_USEDEP}]
	dev-python/qrcode[${PYTHON_USEDEP}]
	dev-python/cryptography[${PYTHON_USEDEP}]
"

src_install() {
	python_moduleinto "gajim/data/plugins"
	python_foreach_impl python_domodule ${MY_PN}
}
