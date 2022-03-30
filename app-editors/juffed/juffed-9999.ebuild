EAPI=7

inherit cmake git-r3 xdg

DESCRIPTION="QScintilla-based tabbed text editor with syntax highlighting"
HOMEPAGE="http://juffed.com/en/ https://github.com/Mezomish/juffed"
EGIT_REPO_URI="https://github.com/Mezomish/juffed.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""

RDEPEND="
	app-i18n/enca
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtprintsupport:5
	dev-qt/qtsingleapplication[X]
	dev-qt/qtwidgets:5
	dev-qt/qtxml:5
	x11-libs/qscintilla
	>=x11-libs/qtermwidget-1.0.0
"
DEPEND="${RDEPEND}"
BDEPEND="dev-qt/linguist-tools:5"

DOCS=( ChangeLog README )

src_prepare() {
	# Upstream version outdated/dysfunctional and CRLF terminated
	cp "${FILESDIR}"/FindQtSingleApplication.cmake cmake/ || die

	cmake_src_prepare

	sed -i -e '/set(CMAKE_CXX_FLAGS/d' CMakeLists.txt || die
}

src_configure() {
	local libdir=$(get_libdir)
	local mycmakeargs=(
		-DUSE_ENCA=ON
		-DUSE_QT5=ON
		-DUSE_SYSTEM_QTSINGLEAPPLICATION=ON
		-DLIB_SUFFIX=${libdir/lib/}
		-DQSCINTILLA_NAMES="qscintilla2;libqscintilla2;qscintilla2_qt5;qscintilla2_qt5"
	)
	cmake_src_configure
}
