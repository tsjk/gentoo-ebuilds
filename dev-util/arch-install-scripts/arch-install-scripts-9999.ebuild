EAPI=7

inherit git-r3

DESCRIPTION="Convenience scripts for installing Arch Linux"
HOMEPAGE="https://github.com/archlinux/arch-install-scripts"
EGIT_REPO_URI="https://github.com/archlinux/arch-install-scripts.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="
	app-shells/bash
	sys-apps/coreutils
	sys-apps/pacman
	sys-apps/util-linux"
DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND="
	app-text/asciidoc
"

src_prepare() {
	sed -i 's/\/usr\/local/\/usr/g' Makefile || die
	default
}
