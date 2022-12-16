# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Powercap Sysfs C Bindings and Utilities"
HOMEPAGE="https://github.com/powercap/powercap"
SRC_URI="https://github.com/${PN}/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="mirror"

DEPEND=""
RDEPEND=""
BDEPEND=""

src_configure() {
	CMAKE_BUILD_TYPE="Release"
	local mycmakeargs=(
		-DBUILD_SHARED_LIBS=ON
	)
	cmake_src_configure
}
