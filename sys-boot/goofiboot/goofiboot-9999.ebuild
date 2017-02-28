# $Id$

EAPI=6

inherit autotools eutils git-r3

DESCRIPTION="UEFI Stub Loader from the Solus Project (gummiboot fork)"
HOMEPAGE="https://github.com/solus-project/goofiboot"
EGIT_REPO_URI="git://github.com/solus-project/goofiboot.git"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS=""
IUSE=""

src_prepare() {
	eautoreconf
	default
}
