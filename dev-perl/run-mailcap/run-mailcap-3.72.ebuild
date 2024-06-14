EAPI=8

inherit perl-module

DESCRIPTION="Run a program specified in the mailcap file based on a mime type"
HOMEPAGE="https://salsa.debian.org/debian/mailcap"
SRC_URI="http://deb.debian.org/debian/pool/main/m/mailcap/mailcap_${PV}.tar.xz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="mirror"

RDEPEND="dev-perl/MIME-Types"
BDEPEND="${RDEPEND}"

S="${WORKDIR}/${P#run-}"

src_install() {
	default
	dobin run-mailcap
	mv run-mailcap.man run-mailcap.1 && doman run-mailcap.1 || die
	dodoc debian/changelog debian/copyright
}
