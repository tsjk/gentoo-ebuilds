EAPI=5
inherit autotools eutils flag-o-matic linux-info

DESCRIPTION="Tool for simple access to the IEEE 1394 (FireWire) bus using the Linux 1394 subsystem. It supports read, write, lock, force bus reset, send phy packets, bus reset notification."
HOMEPAGE="http://firecontrol.sourceforge.net"
SRC_URI="http://sourceforge.net/projects/firecontrol/files/${PN}/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="mirror"

RDEPEND="
		sys-libs/libraw1394
		"

DEPEND="${RDEPEND}"

CONFIG_CHECK="~FIREWIRE"

ERROR_FIREWIRE="
firecontrol works with the (juju) firewire 
stack. You don't seem to have this enabled 
in your kernel configuration.
"
