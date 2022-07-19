# build with
# ACCEPT=~arm emerge-$BOARD flashbench
EAPI="8"

inherit toolchain-funcs

if [[ ${PV} == "9999" ]] ; then
	SRC_URI=""
	EGIT_REPO_URI="https://github.com/bradfa/flashbench.git"
	EGIT_BRANCH="dev"
	inherit git-r3
else
	VER="20120606"
	SRC_URI="https://dev.gentoo.org/~bircoph/distfiles/flashbench-${VER}.tar.xz"
	S=${WORKDIR}/${PN}-${VER}
fi

DESCRIPTION="Flash Storage Benchmark"
HOMEPAGE="https://github.com/bradfa/flashbench"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE=""

PATCHES=("${FILESDIR}"/flashbench-20160801-Makefile-install.patch)

src_configure() {
	tc-export CC
}
