EAPI=8

inherit java-pkg-2 unpacker

DESCRIPTION="epub2pdf is a command-line tool that quickly generates PDF files
from EPUB ebooks. It allows the user to specify page size, fonts, margins, and
default paragraph alignment."
HOMEPAGE="http://epub2pdf.com/"
SRC_URI="http://download.openpkg.org/components/cache/${PN%-bin}/${PN%-bin}-${PV}.zip"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="mirror"

RDEPEND="virtual/jre:1.8"

S="${WORKDIR}"

src_unpack() {
	unpack "$A"
}

src_compile() {
	:
}

src_install() {
	rm ./epub2pdf/epub2pdf.bat ./epub2pdf/epub2pdf.sh || die
	mv "${PN%-bin}" "${PN}" || die
	insinto /usr/share
	doins -r "${PN}"
	java-pkg_regjar "${ED}/usr/share/${PN}/${PN%-bin}.jar"
	java-pkg_dolauncher "${PN}" --jar "${PN%-bin}.jar" --pwd "${EPREFIX}/usr/share/${PN}"
}
