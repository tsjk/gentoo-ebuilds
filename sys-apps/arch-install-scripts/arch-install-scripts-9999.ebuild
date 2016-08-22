# $Header: $

EAPI=6

inherit git-r3

DESCRIPTION="Convenience scripts for installing Arch Linux"
HOMEPAGE="https://github.com/falconindy/arch-install-scripts"
EGIT_REPO_URI="git://github.com/falconindy/arch-install-scripts.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="sys-apps/pacman"
DEPEND=""

src_compile() {
	emake V=1
}

src_install() {
	emake DESTDIR="${D}" PREFIX=/usr install
}
