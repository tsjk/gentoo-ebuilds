# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_{6,7} python3_{4,5,6,7} )

inherit distutils-r1

DESCRIPTION="Ordered Multivalue Dictionary."
HOMEPAGE="https://github.com/gruns/orderedmultidict/ https://pypi.org/project/orderedmultidict/"
SRC_URI="mirror://pypi/o/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="mirror"

RDEPEND="$(python_gen_cond_dep '>=dev-python/ordereddict-1.0.1[${PYTHON_USEDEP}]' python2_6)
	>=dev-python/six-1.8[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	dev-python/setuptools_scm[${PYTHON_USEDEP}]"
