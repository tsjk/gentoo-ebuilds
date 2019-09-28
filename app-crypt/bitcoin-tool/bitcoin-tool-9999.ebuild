# $Id$

EAPI=7

inherit eutils git-r3

DESCRIPTION="Tool for converting Bitcoin keys and addresses"
HOMEPAGE="https://github.com/matja/bitcoin-tool/"
EGIT_REPO_URI="https://github.com/matja/bitcoin-tool.git"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS=""
IUSE=""

DEPEND="dev-libs/openssl[-bindist]
	net-misc/openssh[-bindist]"

src_install() {
	dobin bitcoin-tool
	dodoc README.md
}
