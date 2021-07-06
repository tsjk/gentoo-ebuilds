EAPI=7

DESCRIPTION="ZNC Helper uses message timestamp from a ZNC Bouncer and sets them within Pidgin so that replayed messages will be displayed with the correct timestamp."
HOMEPAGE="https://github.com/kgraefe/pidgin-znc-helper"
SRC_URI="https://github.com/kgraefe/${PN}/releases/download/v${PV}/${P}.tar.gz"

RESTRICT="mirror"
LICENSE="GPLv2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="net-im/pidgin"
RDEPEND="${DEPEND}"

src_install() {
	default

	# The appdata directory is deprecated.
	mv "${ED}"/usr/share/{appdata,metainfo} || die
}
