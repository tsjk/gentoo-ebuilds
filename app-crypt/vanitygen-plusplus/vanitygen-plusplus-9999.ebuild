EAPI=8

inherit git-r3

DESCRIPTION="A vanity address generator for BTC, ETH, LTC, TRX and 100+ more crypto currencies"
HOMEPAGE="https://github.com/10gic/vanitygen-plusplus"
EGIT_REPO_URI="https://github.com/10gic/vanitygen-plusplus.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE="opencl"

DEPEND="
	!app-crypt/vanitygen
	!app-crypt/vanitygen-plus
        dev-libs/libpcre
        dev-libs/openssl
	net-misc/curl
	opencl? ( virtual/opencl )
"

src_compile() {
	if use opencl; then
		emake all
	else
		emake
	fi
}

src_install() {
	dobin keyconv vanitygen++
	dodoc CHANGELOG LICENSE README.md base58prefix.txt
	if use opencl; then
		dobin oclvanitygen++ oclvanityminer
		insinto /usr/lib/oclvanitygen
		newins calc_addrs.cl calc_addrs.cl
	fi
}
