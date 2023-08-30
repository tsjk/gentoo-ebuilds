EAPI=8

inherit autotools flag-o-matic git-r3 linux-info

DESCRIPTION="Linux FireWire bus inspection and configuration tools"
HOMEPAGE="https://github.com/cladisch/linux-firewire-utils"
EGIT_REPO_URI="https://github.com/cladisch/linux-firewire-utils.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""
RESTRICT="mirror"

DEPEND="sys-kernel/linux-headers
	!sys-apps/jujuutils"
RDEPEND=""

CONFIG_CHECK="~FIREWIRE"

ERROR_FIREWIRE="
linux-firewire-utils work with the new (juju) firewire
stack. You don't seem to have this enabled
in your kernel configuration.
"

src_prepare() {
	default
	eautoreconf
}
