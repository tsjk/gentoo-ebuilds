# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit git-r3

DESCRIPTION="USB hub per-port power control"
HOMEPAGE="https://github.com/mvp/uhubctl"
EGIT_REPO_URI="https://github.com/mvp/uhubctl.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="virtual/libusb:1"
RDEPEND="${DEPEND}"
