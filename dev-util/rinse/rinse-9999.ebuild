# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit git-r3

DESCRIPTION="Rinse can setup chroot systems running RPM-based distributions."
HOMEPAGE="http://www.steve.org.uk/Software/rinse/"
EGIT_REPO_URI="git://anonscm.debian.org/collab-maint/rinse.git"

LICENSE="|| ( Artistic GPL-1+ )" # see bin/rinse LICENSE (same terms as Perl itself)
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="app-arch/rpm
	dev-lang/perl
	sys-apps/yum
"
RDEPEND="${DEPEND}"

src_compile() {
	:
}

src_install() {
	emake PREFIX="${D}" install || die
}
