EAPI=7

inherit eutils git-r3

DESCRIPTION="nvramtool is a utility for reading/writing/displaying LinuxBIOS parameters."
HOMEPAGE="http://www.coreboot.org/nvramtool"
EGIT_REPO_URI="https://github.com/coreboot/coreboot.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

S="${S}/util/${PN}"

src_install() {
	dobin ${PN} || die "dobin failed"
	doman cli/${PN}.8
	dodoc README
}

pkg_postinst() {
	ewarn "The machine must be booted with LinuxBIOS to use this program."
}
