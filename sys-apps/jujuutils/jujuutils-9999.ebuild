# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit autotools eutils flag-o-matic git-r3 linux-info

DESCRIPTION="Linux FireWire bus inspection and configuration tools"
HOMEPAGE="http://code.google.com/p/jujuutils/"
EGIT_REPO_URI="https://code.google.com/p/jujuutils"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""
RESTRICT="mirror"

DEPEND="sys-kernel/linux-headers"
RDEPEND=""

CONFIG_CHECK="~FIREWIRE"

ERROR_FIREWIRE="
jujuutils work with the new (juju) firewire 
stack. You don't seem to have this enabled 
in your kernel configuration.
"

src_prepare() {
	eautoreconf
}
