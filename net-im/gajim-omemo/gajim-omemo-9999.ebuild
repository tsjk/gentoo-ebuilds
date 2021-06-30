# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7,8,9} )

DESCRIPTION="Gajim plugin for OMEMO XMPP end-to-end encryption"
HOMEPAGE="https://dev.gajim.org/gajim/gajim-plugins/wikis/OmemoGajimPlugin"

EGIT_REPO_URI="https://dev.gajim.org/gajim/gajim-plugins.git"

if [[ "${PV}" = "9999" ]] ; then
	inherit git-r3
	KEYWORDS=""
else
	SRC_URI="https://ftp.gajim.org/plugins_releases/omemo_${PV}.zip"
	KEYWORDS="~amd64"
fi

MY_PN="omemo"

inherit python-r1

LICENSE="GPL-3"
SLOT="0"
RESTRICT="mirror"

S="${WORKDIR}/${P}"

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
