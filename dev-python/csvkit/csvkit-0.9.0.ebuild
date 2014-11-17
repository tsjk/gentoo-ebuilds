# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python2_6 python2_7 python3_3 python3_4 )
inherit distutils-r1

MY_PV="${PV}"

DESCRIPTION="csvkit is a suite of utilities for converting to and working with CSV."
HOMEPAGE="http://csvkit.readthedocs.org/en/0.9.0/"
SRC_URI="https://pypi.python.org/packages/source/c/csvkit/csvkit-0.9.0.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="mirror"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	=dev-python/dbf-0.94.003
	>=dev-python/openpyxl-2.0.3
	>=dev-python/ordereddict-1.1
	=dev-python/python-dateutil-2.2
	>=dev-python/simplejson-3.6.3
	>=dev-python/sqlalchemy-0.6.6
	>=dev-python/sphinx-1.0.7
	>=dev-python/xlrd-0.7.1
"

S=${WORKDIR}/${PN}-${MY_PV}
