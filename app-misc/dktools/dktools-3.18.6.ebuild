EAPI=5
inherit autotools eutils flag-o-matic

DESCRIPTION="A collection of several tools by Dirk Krause. dktools includes graphic converters, text converters, some daemons, Perl modules, some development tools, administration tools and printing tools."
HOMEPAGE="http://dktools.sourceforge.net"
SRC_URI="http://sourceforge.net/projects/dktools/files/${PN}/${P}/${P}.tar.gz"

LICENSE="dktools"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="mirror"

RDEPEND="
		app-arch/bzip2
		dev-libs/openssl
		media-libs/libpng
		media-libs/tiff
		media-libs/netpbm
		net-analyzer/net-snmp
		>=sys-libs/db-4
		sys-libs/gdbm
		sys-libs/zlib
		virtual/jpeg
		x11-libs/wxGTK
		"

DEPEND="${RDEPEND}"
