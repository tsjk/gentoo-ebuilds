# $Id$

EAPI=6

inherit eutils git-r3

DESCRIPTION="nvramtool is a utility for reading/writing/displaying LinuxBIOS parameters."
HOMEPAGE="http://www.coreboot.org/nvramtool"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

SRC_URI=""
EGIT_REPO_URI="git://github.com/coreboot/coreboot.git"

S="${S}/util/${PN}"

src_install() {
	dobin ${PN} || die "dobin failed"
	doman cli/${PN}.8
	dodoc README
}

pkg_postinst() {
	ewarn "The machine must be booted with LinuxBIOS to use this program."
}
