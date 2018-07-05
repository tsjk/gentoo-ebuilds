# Copyright 1999-2018 The Bentoo Authors. All rights reserved
# Distributed under the terms of the GNU General Public License v3 or later

EAPI=6

inherit cmake-utils readme.gentoo-r1

DESCRIPTION="The minimalist fan control program -- rewritten in clean C++11"
HOMEPAGE="https://github.com/vmatare/thinkfan"
SRC_URI="https://github.com/vmatare/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="atasmart yaml"

DEPEND="atasmart? ( dev-libs/libatasmart )
	yaml? ( dev-cpp/yaml-cpp )"
RDEPEND="${DEPEND}"

src_prepare() {
	cmake-utils_src_prepare

	sed -e "s:share/doc/${PN}:share/doc/${PF}:" \
		-i CMakeLists.txt
}

src_configure() {
	local mycmakeargs+=(
		"-DCMAKE_BUILD_TYPE:STRING=Debug"
		"-DUSE_ATASMART=$(usex atasmart)"
	)

	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install

	readme.gentoo_create_doc
}

DOC_CONTENTS="Please read the documentation and copy an
appropriate file to /etc/thinkfan.conf."
