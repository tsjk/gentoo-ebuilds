EAPI=5
inherit eutils

DESCRIPTION="Shell scripts for Linux/Unix/MacOSX convert FIG files to EPS and PDF (via Ghostscript), allowing you to easily embed TeX output in your pictures."
HOMEPAGE="http://www.few.vu.nl/~wkager/tools.htm"
SRC_URI="http://www.few.vu.nl/~wkager/download/PrintTools110601.tgz"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="mirror"

RDEPEND="
		app-text/ghostscript-gpl
		app-text/poppler
		app-text/psutils
		net-print/cups
		sys-apps/coreutils
		sys-apps/gawk
		sys-apps/sed
		"

DEPEND="${RDEPEND}"

S="${WORKDIR}"

src_install() {
	into "/usr"
	dobin p1up p2up p4up p8up pbook
}
