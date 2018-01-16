EAPI=5
inherit eutils

DESCRIPTION="Shell scripts for Linux/Unix/MacOSX convert FIG files to EPS and PDF (via Ghostscript), allowing you to easily embed TeX output in your pictures."
HOMEPAGE="http://www.few.vu.nl/~wkager/tools.htm"
SRC_URI="http://www.few.vu.nl/~wkager/download/FIGTools150801.tgz"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="mirror"

RDEPEND="
		app-text/ghostscript-gpl
		sys-apps/coreutils
		sys-apps/gawk
		sys-apps/grep
		sys-apps/sed
		media-gfx/transfig
		virtual/latex-base
		"

DEPEND="${RDEPEND}"

S="${WORKDIR}"

src_install() {
	into "/usr"
	dobin fig2eps fig2pdf
}
