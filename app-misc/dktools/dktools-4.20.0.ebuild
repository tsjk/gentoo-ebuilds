EAPI=7

WX_GTK_VER=3.0

inherit wxwidgets

DESCRIPTION="A collection of several tools by Dirk Krause. dktools includes graphic converters, text converters, some daemons, Perl modules, some development tools, administration tools and printing tools."
HOMEPAGE="http://dktools.sourceforge.net"
SRC_URI="https://sourceforge.net/projects/dktools/files/${PN}/${P}/${P}.tar.gz"

LICENSE="dktools"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="mirror"

RDEPEND="
		app-arch/bzip2
		dev-db/mariadb-connector-c
		dev-libs/openssl
		media-libs/libpng
		media-libs/tiff
		media-libs/netpbm
		media-libs/wxsvg
		net-analyzer/net-snmp
		>=sys-libs/db-4
		sys-libs/gdbm
		sys-libs/zlib
		virtual/jpeg
		x11-libs/wxGTK:3.0
		"

DEPEND="${RDEPEND}"

src_prepare() {
	default
	sed -i -E "s@MYSQLLIB='-lmariadbclient'@MYSQLLIB='-lmariadb'@" "${S}/configure.ac" "${S}/configure" || die
}

src_configure() {
	setup-wxwidgets
	CC="gcc" econf --enable-shared=yes --enable-packaging=yes
}

src_install() {
	default
	mkdir -m0755 -p "${ED}/usr/include"
	keepdir /var/lib/lib
	keepdir /var/lib/log
	keepdir /var/lib/run
	export QA_DT_NEEDED=$(find "${ED}" -type f -name 'libdk4m*.so.*' -printf '/%P\n')
}
