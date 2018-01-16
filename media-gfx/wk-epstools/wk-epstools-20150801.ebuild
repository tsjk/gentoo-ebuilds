EAPI=6
inherit eutils

DESCRIPTION="A collection of shell scripts for Linux/Unix to convert EPS files to PDF, PNG and JPEG (via Ghostscript)."
HOMEPAGE="http://www.few.vu.nl/~wkager/tools.htm"
SRC_URI="http://www.few.vu.nl/~wkager/download/EPSTools150801.tgz"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="mirror"

RDEPEND="
		app-text/ghostscript-gpl
		sys-apps/coreutils
		sys-apps/gawk
		sys-apps/sed
		"

DEPEND="${RDEPEND}"

S="${WORKDIR}"

src_install() {
	into "/usr"
	dobin eps2jpg eps2pdf eps2png
}
