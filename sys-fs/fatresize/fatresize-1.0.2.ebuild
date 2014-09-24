# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:

EAPI=5

inherit autotools base eutils flag-o-matic

DESCRIPTION="The FAT16/FAT32 non-destructive resizer"
HOMEPAGE="http://sourceforge.net/projects/fatresize/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE=""

DEPEND=">=sys-block/parted-3.1"
RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}"/${P}-libparted_ver_check.patch
	"${FILESDIR}"/${P}-ped_assert.patch
	"${FILESDIR}"/${P}-ped_free.patch
	)

src_prepare() {
	epatch ${PATCHES[@]}
	eautoreconf
}
