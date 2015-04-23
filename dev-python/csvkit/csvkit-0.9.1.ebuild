# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7,3_3,3_4} )
inherit distutils-r1 python-r1

MY_PV="${PV}"

DESCRIPTION="csvkit is a suite of utilities for converting to and working with CSV."
HOMEPAGE="http://csvkit.readthedocs.org/en/${PV}/"
SRC_URI="https://pypi.python.org/packages/source/c/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="mirror"

RDEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	$(python_gen_cond_dep '>=dev-python/argparse-1.2.1[${PYTHON_USEDEP}]' python2_6)
	$(python_gen_cond_dep '>=dev-python/ordereddict-1.1[${PYTHON_USEDEP}]' python2_6)
	$(python_gen_cond_dep '>=dev-python/simplejson-3.6.3[${PYTHON_USEDEP}]' python2_6)
	$(python_gen_cond_dep '=dev-python/dbf-0.94.003[${PYTHON_USEDEP}]' python2_7)
	=dev-python/openpyxl-2.2.0_beta1[${PYTHON_USEDEP}]
	=dev-python/python-dateutil-2.2[${PYTHON_USEDEP}]
	>=dev-python/sqlalchemy-0.6.6[${PYTHON_USEDEP}]
	>=dev-python/sphinx-1.0.7[${PYTHON_USEDEP}]
	>=dev-python/xlrd-0.7.1[${PYTHON_USEDEP}]
"

S=${WORKDIR}/${PN}-${MY_PV}
