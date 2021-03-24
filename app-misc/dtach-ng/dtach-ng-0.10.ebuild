EAPI=7

DESCRIPTION="A simple program that emulates the detach feature of screen (dtach-ng fork)."
HOMEPAGE="https://github.com/xPMo/dtach"
SRC_URI="https://github.com/xPMo/dtach/archive/v${PV}.tar.gz -> ${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sparc ~x86 ~x64-macos"
IUSE=""
RESTRICT="mirror"

DEPEND="!app-misc/dtach-ng"

S="${WORKDIR}/dtach-${PV}"

src_install() {
	dobin dtach
	doman dtach.1
	dodoc README
}
