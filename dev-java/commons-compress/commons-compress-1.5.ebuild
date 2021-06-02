# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

JAVA_PKG_IUSE="doc source"
MAVEN_ID="org.apache.commons:commons-compress:1.5"

inherit java-pkg-2 java-pkg-simple

DESCRIPTION="Java API for working with archive files"
HOMEPAGE="https://commons.apache.org/proper/commons-compress/"
SRC_URI="https://archive.apache.org/dist/commons/compress/source/${P}-src.tar.gz -> ${P}-sources.tar.gz"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 x86"
RESTRICT="mirror"

CDEPEND="
	dev-java/xz-java:0
"

DEPEND="
	>=virtual/jdk-1.8:*
	${CDEPEND}
"

RDEPEND="
	>=virtual/jre-1.8:*
	${CDEPEND}"

S="${WORKDIR}/${P}-src"

JAVA_ENCODING="iso-8859-1"

JAVA_GENTOO_CLASSPATH="xz-java"
JAVA_SRC_DIR="src/main/java"
