EAPI=8

LUA_COMPAT=( lua5-{3..4} luajit )
inherit git-r3 lua-single plocale toolchain-funcs

DESCRIPTION="Window matching utility with Lua scripting"
HOMEPAGE="https://www.nongnu.org/devilspie2/"
EGIT_REPO_URI="https://github.com/dsalt/devilspie2.git"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS=""
REQUIRED_USE="${LUA_REQUIRED_USE}"

RDEPEND="
	${LUA_DEPS}
	dev-libs/glib:2
	x11-libs/gtk+:3
	x11-libs/libX11
	x11-libs/libXinerama
	x11-libs/libXrandr
	x11-libs/libwnck:3
"
DEPEND="
	${RDEPEND}
	x11-base/xorg-proto
"
BDEPEND="
	sys-devel/gettext
	virtual/pkgconfig
"

src_compile() {
	tc-export CC PKG_CONFIG

	local PLOCALES="fi fr it ja nl pt_BR ru sv"

	DEVILSPIE2_ARGS=(
		PREFIX="${EPREFIX}"/usr
		LANGUAGES="$(plocale_get_locales)"
		LUA="${ELUA}"
	)

	mkdir obj || die # race condition (bug #881473)
	emake "${DEVILSPIE2_ARGS[@]}"
}

src_install() {
	emake DESTDIR="${D}" "${DEVILSPIE2_ARGS[@]}" install
	einstalldocs

	dodoc -r doc/examples
}
