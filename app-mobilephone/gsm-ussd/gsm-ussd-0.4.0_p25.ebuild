EAPI=5

HOMEPAGE="http://linux.zum-quadrat.de/"
SRC_URI="http://linux.zum-quadrat.de/downloads/${PN}_${PV/_p/-}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="mirror"

RDEPEND="	>=dev-lang/perl-5.8
		"

DEPEND="${RDEPEND}"

S="${WORKDIR}/${PN}_${PV/_p/-}"

src_prepare() {
	sed -i 's/^=item\ B<\*102#>/=item\ \*\ B<\*102#>/' docs/gsm-ussd.en.pod
}

src_compile() {
	emake all
}

src_install() {
	make install install-doc PREFIX="${D}/usr"
}
