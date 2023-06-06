EAPI=8

inherit autotools git-r3

DESCRIPTION="Automated Core Lightning Node Manager"
HOMEPAGE="https://github.com/ZmnSCPxj/clboss"
EGIT_REPO_URI="https://github.com/ZmnSCPxj/clboss.git"

SLOT="0"
LICENSE="Apache-2.0"
KEYWORDS=""
IUSE="+curl_ssl_gnutls curl_ssl_openssl"

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
	<=net-p2p/core-lightning-23.06
"

PATCHES=(
		"${FILESDIR}/0001-clboss-destroyearningsinfo.patch"
		"${FILESDIR}/0002-clboss-tallly.patch"
)

src_prepare() {
	default
	if has_version '>=net-p2p/core-lightning-23.05' ; then
		eapply "${FILESDIR}/0003-removed_msat_suffix.patch"
	fi
	eautoreconf
}
