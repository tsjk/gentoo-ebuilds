EAPI=8

inherit unpacker xdg

DESCRIPTION="Cryptocurrency Wallet"
HOMEPAGE="https://www.exodus.com/"

SRC_URI="https://downloads.exodus.com/releases/exodus-linux-x64-${PV}.deb"

LICENSE="all-rights-reserved no-source-code"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""
RESTRICT="mirror"

QA_PREBUILT="*"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

S="${WORKDIR}"

src_install() {
	mv "${S}/usr/share/doc/exodus" "${S}/usr/share/doc/${P}"

	mkdir "${S}"/opt
	mv "${S}"/usr/lib/exodus "${S}"/opt
	cp -a "${S}"/* "${D}" || die
	dosym ../../opt/exodus/Exodus /usr/bin/exodus
	fperms 4755 "/opt/exodus/chrome-sandbox"
}
