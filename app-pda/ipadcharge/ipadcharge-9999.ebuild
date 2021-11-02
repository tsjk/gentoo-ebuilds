EAPI=7

inherit autotools git-r3 eutils flag-o-matic

DESCRIPTION="Enables USB charging for Apple devices."
HOMEPAGE="https://github.com/mkorenkov/ipad_charge"
EGIT_REPO_URI="https://github.com/mkorenkov/ipad_charge.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="dev-libs/libusb:1"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${P}"

PATCHES=("${FILESDIR}/${PN}-9999-makefile.patch")

src_prepare() {
	default
	#sed -i 's|\/usr|\$\{DESTDIR\}\/usr|g' Makefile
	#sed -i 's|\/etc|\$\{DESTDIR\}\/etc|g' Makefile
}
