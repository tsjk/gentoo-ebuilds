EAPI=8

DISTUTILS_USE_PEP517=no
PYTHON_COMPAT=( python3_{9..10} )
inherit distutils-r1

DESCRIPTION="noVNC is a VNC client implemented using HTML5 technologies"
HOMEPAGE="https://github.com/novnc/noVNC"

if [[ ${PV} == *9999 ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/kanaka/noVNC.git"
else
	SRC_URI="https://github.com/kanaka/noVNC/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="amd64 ~arm64 ~riscv x86 ~amd64-linux ~x86-linux"
	RESTRICT="mirror"
	S="${WORKDIR}/noVNC-${PV}"
fi

LICENSE="LGPL-3"
SLOT="0"

RDEPEND="
	dev-python/websockify[${PYTHON_USEDEP}]
	dev-python/numpy[${PYTHON_USEDEP}]"

python_compile() {
	:
}

src_install() {
	exeinto /usr/share/novnc/utils
	for f in utils/*; do
		[[ ! f = utils/README.md ]] && doexe $f
	done

	dodoc README.md LICENSE.txt

	insinto /usr/share/novnc
	doins -r vnc.html vnc_lite.html app/ core/ vendor/
	dosym vnc_lite.html /usr/share/novnc/vnc_auto.html  # for compat
	dosym ../share/novnc/utils/novnc_proxy /usr/bin/novnc
}
