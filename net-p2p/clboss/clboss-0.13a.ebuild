EAPI=8

DESCRIPTION="Automated Core Lightning Node Manager"
HOMEPAGE="https://github.com/ZmnSCPxj/clboss"
SRC_URI="https://github.com/ZmnSCPxj/${PN}/releases/download/${PV^^}/${PN}-${PV^^}.tar.gz"

SLOT="0"
LICENSE="Apache-2.0"
KEYWORDS=""
IUSE="+curl_ssl_gnutls curl_ssl_openssl"
RESTRICT="mirror"

S="${WORKDIR}/${PN}-${PV^^}"

DEPEND="
	dev-db/sqlite:=
	dev-libs/gmp:=[cxx]
	dev-libs/libev:=
	net-misc/curl:=[cxx,ssl]
	curl_ssl_gnutls? ( net-libs/gnutls:=[cxx] )
	curl_ssl_openssl? ( dev-libs/openssl:= )
"

RDEPEND="
	${DEPEND}
	net-dns/bind-tools
	<net-p2p/core-lightning-0.12
"
