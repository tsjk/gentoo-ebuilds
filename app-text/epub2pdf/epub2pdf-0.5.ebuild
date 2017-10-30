# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit java-pkg-2 java-ant-2

DESCRIPTION="epub2pdf is a command-line tool that quickly generates PDF files
from EPUB ebooks. It allows the user to specify page size, fonts, margins, and
default paragraph alignment."
HOMEPAGE="http://epub2pdf.com/"
SRC_URI="http://epub2pdf.com/files/epub2pdf-$PV-src-all.zip"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="mirror"

RDEPEND="dev-java/batik:1.9
	>=dev-java/itext-2.1.5:0
	>=dev-java/sac-1.3:0
	>=dev-java/saxon-6.5.5:6.5
	>=dev-java/xml-commons-resolver-1.2:0
	dev-java/xerces:2
	>=virtual/jre-1.6"
DEPEND="app-arch/unzip
	>=virtual/jdk-1.6
	${RDEPEND}"

S="${WORKDIR}"

src_unpack() {
	unpack "$A"
	unzip "$P-src.jar"
}

src_compile() {
	find . -name "*.java" > "${T}/src.list"
	mkdir classes
	ejavac -d classes -classpath \
	$(java-pkg_getjars \
	batik-1.9,itext,sac,saxon-6.5,xml-commons-resolver,xerces-2) \
	"@${T}/src.list"
	cd classes
	jar -cf ../$PN.jar *
}

src_install() {
	java-pkg_dojar $PN.jar
	java-pkg_dolauncher $PN --main com.amphisoft.epub2pdf.Epub2Pdf
}
