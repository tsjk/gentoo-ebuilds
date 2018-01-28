EAPI=6

inherit eutils

DESCRIPTION="Rinse can setup chroot systems running RPM-based distributions."
HOMEPAGE="http://www.steve.org.uk/Software/rinse/"

SRC_URI="https://anonscm.debian.org/gitweb/?p=collab-maint/rinse.git;a=snapshot;h=2a9d9fe5804ef1d6adc84d7d32da674050b43b1b;sf=tgz -> ${P}.tar.gz"

LICENSE="|| ( Artistic GPL-1+ )" # see bin/rinse LICENSE (same terms as Perl itself)
SLOT="0"
KEYWORDS="~amd64"
IUSE=""
RESTRICT="mirror"

DEPEND="app-arch/rpm
	dev-lang/perl
	sys-apps/yum
"
RDEPEND="${DEPEND}"

S="${WORKDIR}/rinse-2a9d9fe"

src_compile() {
	:
}

src_install() {
	emake PREFIX="${D}" install || die
}
