EAPI=8

inherit git-r3

DESCRIPTION="Tool for converting Bitcoin keys and addresses"
HOMEPAGE="https://github.com/matja/bitcoin-tool/"
EGIT_REPO_URI="https://github.com/matja/bitcoin-tool.git"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS=""
IUSE=""

DEPEND="|| ( <dev-libs/openssl-1.1.1l-r1[-bindist] >=dev-libs/openssl-1.1.1l-r1 )
	|| ( <net-misc/openssh-8.7_p1-r3[-bindist] >=net-misc/openssh-8.7_p1-r3 )"

src_install() {
	dobin bitcoin-tool
	dodoc README.md
}
