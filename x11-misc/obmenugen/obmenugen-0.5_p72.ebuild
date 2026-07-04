EAPI=9

MY_P="${PN}-${PV/_p/-r}"
C_PV="$(ver_cut 1-2)"

DESCRIPTION="Static/dynamic menu-generator for Openbox"
HOMEPAGE="https://launchpad.net/obmenugen"
SRC_URI="http://launchpad.net/${PN}/${C_PV}/${PV/_p*/}/+download/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="app-text/txt2tags
	dev-lang/dmd:1"
RDEPEND="!x11-misc/obmenugen-bin
	x11-wm/openbox"

S="${WORKDIR}/${MY_P}"

src_compile() {
	# build obmenugen with dmd:1
	if [ -e "${EPREFIX}/usr/bin/dmd1" ]; then
		dmd1 src/*.d -O -release -inline -od"${T}" -ofobmenugen \
		|| die "build failed!"
	else
		# fallback if you don't use dmd from sunrise-overlay
		dmd src/*.d -O -release -inline -od"${T}" -ofobmenugen \
		|| die "build failed! for 'd-overlay' use eselect to switch to dmd:1"
	fi

	txt2tags -i html/src/obmenugen-html.t2t -o obmenugen.html \
	|| die "converting failed!"
}

src_install() {
	dobin obmenugen
	insinto /usr/share/obmenugen/
	doins -r translations
	dodoc README.txt
	dohtml obmenugen.html
}
