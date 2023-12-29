EAPI=8

inherit autotools git-r3

DESCRIPTION="Bluetooth helper tools for setting up serial ports for e.g. SSH"
HOMEPAGE="https://github.com/ThomasHabets/bthelper"
EGIT_REPO_URI="https://github.com/ThomasHabets/bthelper.git"
PATCHES=( "${FILESDIR}/0000-cstdint.patch" )

SLOT="0"
LICENSE="Apache-2.0"
KEYWORDS=""
IUSE=""

src_prepare() {
	default
	eautoreconf
}
