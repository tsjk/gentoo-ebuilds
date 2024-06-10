EAPI=8

inherit autotools flag-o-matic git-r3

DESCRIPTION="OpenSMTPD sqlite table addon"
HOMEPAGE="https://github.com/OpenSMTPD/OpenSMTPD-extras"
EGIT_REPO_URI="https://github.com/OpenSMTPD/OpenSMTPD-extras.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="
	dev-db/sqlite
	mail-mta/opensmtpd
	"
DEPEND="${RDEPEND}"

PATCHES=(
	"${FILESDIR}/0001-remove-ltls.patch"
	"${FILESDIR}/0002-add-foreign.patch"
)

QA_CONFIG_IMPL_DECL_SKIP=(
        SSLeay_add_all_algorithms
        exit
	printf
	unlink
)

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	append-cppflags -D_DEFAULT_SOURCE
	econf \
		--with-mantype=man \
		--with-table-sqlite
}
