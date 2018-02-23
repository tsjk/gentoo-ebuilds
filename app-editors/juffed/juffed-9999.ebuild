# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

CMAKE_REMOVE_MODULES="no"

inherit cmake-utils git-r3

DESCRIPTION="QScintilla-based tabbed text editor with syntax highlighting"
HOMEPAGE="http://juffed.com/
	https://github.com/Mezomish/juffed"
EGIT_REPO_URI="https://github.com/Mezomish/juffed.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="debug qt5"

DEPEND="app-i18n/enca
	!qt5? ( >=dev-qt/qtcore-4.2:4
		>=dev-qt/qtgui-4.2:4
		=dev-qt/qtsingleapplication-2.6.1_p20150629[X,qt4]
		>=x11-libs/qscintilla-2.1:=[qt4] )
	qt5? ( dev-qt/linguist-tools:5
		dev-qt/qtcore:5
		dev-qt/qtgui:5
		dev-qt/qtnetwork:5
		dev-qt/qtprintsupport:5
		|| ( =dev-qt/qtsingleapplication-2.6.1_p20150629[X,qt5] >=dev-qt/qtsingleapplication-2.6.1_p20171024[X] )
		dev-qt/qtwidgets:5
		dev-qt/qtxml:5
		>=x11-libs/qscintilla-2.1:=[qt5] )"
RDEPEND=${DEPEND}

DOCS=( ChangeLog README )

src_prepare() {
	cmake-utils_src_prepare

	sed -i -e '/set(CMAKE_CXX_FLAGS/d' CMakeLists.txt || die

	if use qt5 ; then
		# Explicitly select Qt5
		eapply "${FILESDIR}/${P}-use-qt5.patch"

		# Fix a library name
		sed -i -e 's/QtSolutions_/Qt5Solutions_/g' cmake/FindQtSingleApplication.cmake

		# Fix for Qscintilla v2.10
		has_version ">=x11-libs/qscintilla-2.10" && eapply "${FILESDIR}/${P}-with-qscintilla-2.10.patch"

		# Fix another library name
		sed -i -E '/^\s*SET\(QSCINTILLA_NAMES\ /s/\)$/\ qscintilla2\ libqscintilla2\)/' cmake/FindQScintilla2.cmake
	else
		# Explicitly select Qt4
		eapply "${FILESDIR}/${P}-use-qt4.patch"
	fi

	eapply_user
}

src_configure() {
	local mycmakeargs=( \
		-DUSE_ENCA=ON \
		-DUSE_QT5="$(usex qt5)" \
		-DQT_INCLUDE_DIR="/usr/include/$(usex qt5 'qt5' 'qt4')" \
		-DQT_LIBRARY_DIR="/usr/$(get_libdir)$(usex qt5 '' '/qt4')" \
		-DUSE_SYSTEM_QTSINGLEAPPLICATION=ON )

	cmake-utils_src_configure
}
