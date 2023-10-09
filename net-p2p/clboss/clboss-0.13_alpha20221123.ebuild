EAPI=8

inherit autotools

COMMIT="f4a7715ab7e0480c9b73aa34165ff928e89fc2a2"
DESCRIPTION="Automated Core Lightning Node Manager"
HOMEPAGE="https://github.com/ZmnSCPxj/clboss"
SRC_URI="https://github.com/ZmnSCPxj/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

SLOT="0"
LICENSE="Apache-2.0"
KEYWORDS="~amd64 ~arm64 ~x86"
IUSE="+curl_ssl_gnutls curl_ssl_openssl"
RESTRICT="mirror"

S="${WORKDIR}/${PN}-${COMMIT}"

DEPEND="
	dev-db/sqlite:=
	dev-libs/gmp:=[cxx]
	dev-libs/libev:=
	net-misc/curl:=[ssl]
	curl_ssl_gnutls? ( net-libs/gnutls:=[cxx] )
	curl_ssl_openssl? ( dev-libs/openssl:= )
"

RDEPEND="
	${DEPEND}
	net-dns/bind-tools
	>=net-p2p/core-lightning-0.9.1
	|| ( <net-p2p/core-lightning-22 ~net-p2p/core-lightning-22.11.1 )
	<net-p2p/core-lightning-23
"

PATCHES=(
		"${FILESDIR}/0001-clboss-destroyearningsinfo.patch"
		"${FILESDIR}/0002-clboss-tallly.patch"
)

src_prepare() {
	default
	eautoreconf
}
