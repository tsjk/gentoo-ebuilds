EAPI=8

PYTHON_COMPAT=( python{3_9,3_10} )

CMAKE_MAKEFILE_GENERATOR=ninja

EGIT_REPO_URI="https://github.com/baruch/diskscan.git"

inherit cmake git-r3 python-single-r1

DESCRIPTION="Scan disk for bad or near failure sectors, performs disk diagnostics"
HOMEPAGE="http://blog.disksurvey.org/proj/diskscan/"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="$(python_gen_cond_dep '
		dev-python/pyyaml[${PYTHON_USEDEP}]
        ')
	dev-util/ctags
	dev-util/ninja
	sys-libs/libtermcap-compat
	sys-libs/ncurses
	sys-libs/zlib"
RDEPEND="${DEPEND}"

DOCS=( DEVELOP.md README.md )

