# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop java-pkg-2 xdg

MY_PN="NetLogo"
MY_P=${MY_PN}-${PV}

DESCRIPTION="Programming language and IDE for agent-based modelling"
HOMEPAGE="https://ccl.northwestern.edu/netlogo/"
SRC_URI="
	https://netlogoweb.org/assets/images/desktopicon.png -> ${PN//-bin}.png
	amd64? ( https://ccl.northwestern.edu/netlogo/${PV}/${MY_P}-64.tgz )
	x86? ( https://ccl.northwestern.edu/netlogo/${PV}/${MY_P}-32.tgz )
"
S="${WORKDIR}/${MY_PN} ${PV}"

LICENSE="netlogo GPL-2 LGPL-2.1 LGPL-3 BSD Apache-2.0"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"

RDEPEND="
	>=virtual/jre-17:*
	media-libs/mesa
	sys-libs/glibc
	x11-libs/libdrm
	x11-libs/libX11
	x11-libs/libXrender
	x11-libs/libXxf86vm
"

DOCS=(
	"readme.md"
	"NetLogo User Manual.pdf"
	"Mathematica Link/NetLogo-Mathematica Tutorial.pdf"
	"behaviorsearch/README.TXT"
)
HTML_DOCS=(
	"docs"
	"behaviorsearch/documentation"
)

QA_PREBUILT="opt/netlogo/natives/linux-*/*.so"

src_unpack() {
	if use amd64; then
		S="${WORKDIR}/${MY_PN}-${PV}-64"
	elif use x86; then
		S="${WORKDIR}/${MY_PN}-${PV}-32"
	fi

	default
}

src_install() {
	einstalldocs

	# Remove the bundled libs if we are not installing on this arch
	# This avoids: "QA Notice: Unresolved SONAME dependencies:"
	if ! use amd64; then
		rm -r natives/linux-amd64 || die
	fi
	if ! use x86; then
		rm -r natives/linux-i586 || die
	fi

	# Delete bundled runtime library and other stuff not needed
	rm -r lib/runtime || die
	rm lib/libapplauncher.so || die

	local basedir="/opt/${PN//-bin}"
	insinto "${basedir}"
	doins -r behaviorsearch/ docs/ lib/ extensions/ models/ natives/
	# The whitespace causes issues when we try to java-pkg_regjar, because
	# classpath can't contain paths with whitespaces
	mv "Mathematica Link/" "MathematicaLink/" || die
	doins -r "MathematicaLink/"

	doicon -s 256x256 "${DISTDIR}/${PN//-bin}.png"
	doicon -s scalable behaviorsearch/resources/icon_behaviorsearch.svg
	doicon -s 256x256 behaviorsearch/resources/icon_behaviorsearch.png

	# Register all these jars so they are available in the classpath
	for jar in "${ED}/${basedir}/lib/app/"*.jar ; do
		java-pkg_regjar "${jar}"
	done
	java-pkg_regjar "${ED}/${basedir}/MathematicaLink/mathematica-link.jar"

	use amd64 && java-pkg_dolauncher netlogo3d \
		--main org.nlogo.app.App \
		--pwd "${EPREFIX}/${basedir}" \
		--java_args "-Dnetlogo.extensions.dir=${EPREFIX}/${basedir}/extensions -Dorg.nlogo.is3d=true -Djava.library.path=${EPREFIX}/${basedir}/natives/linux-amd64/:\${env_var:PATH}"
	use x86 && java-pkg_dolauncher netlogo3d \
		--main org.nlogo.app.App \
		--pwd "${EPREFIX}/${basedir}" \
		--java_args "-Dnetlogo.extensions.dir=${EPREFIX}/${basedir}/extensions -Dorg.nlogo.is3d=true -Djava.library.path=${EPREFIX}/${basedir}/natives/linux-i586/:\${env_var:PATH}"
	java-pkg_dolauncher netlogo \
		--main org.nlogo.app.App \
		--pwd "${EPREFIX}/${basedir}" \
		--java_args "-Dnetlogo.extensions.dir=${EPREFIX}/${basedir}/extensions"
	java-pkg_dolauncher netlogo-headless \
		--main org.nlogo.headless.Main \
		--pwd "${EPREFIX}/${basedir}" \
		--java_args "-Dnetlogo.extensions.dir=${EPREFIX}/${basedir}/extensions"
	java-pkg_dolauncher hubnetclient \
		--main org.nlogo.hubnet.client.App \
		--pwd "${EPREFIX}/${basedir}" \
		--java_args "-Dnetlogo.extensions.dir=${EPREFIX}/${basedir}/extensions -Dorg.nlogo.is3d=true"
	java-pkg_dolauncher behaviorsearch \
		--main bsearch.app.BehaviorSearchGUI \
		--pwd "${EPREFIX}/${basedir}" \
		--java_args "-Dbsearch.startupfolder=${EPREFIX}/${basedir} -Dbsearch.appfolder=${EPREFIX}/${basedir}/behaviorsearch -server"
	java-pkg_dolauncher behaviorsearch-headless \
		--main bsearch.app.BehaviorSearch \
		--pwd "${EPREFIX}/${basedir}" \
		--java_args "-Dbsearch.startupfolder=${EPREFIX}/${basedir} -Dbsearch.appfolder=${EPREFIX}/${basedir}/behaviorsearch -server"

	make_desktop_entry netlogo "NetLogo" netlogo
	make_desktop_entry netlogo3d "NetLogo 3D" netlogo
	make_desktop_entry hubnetclient "NetLogo Hubnet Client" netlogo
	make_desktop_entry behaviorsearch "NetLogo Behavior Search" icon_behaviorsearch
}
