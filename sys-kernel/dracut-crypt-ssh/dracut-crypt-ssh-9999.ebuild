EAPI=7

inherit autotools eutils git-r3

DESCRIPTION="Early unlocking of encrypted systems via ssh for dracut"
HOMEPAGE="https://github.com/dracut-crypt-ssh/dracut-crypt-ssh"
EGIT_REPO_URI="git://github.com/dracut-crypt-ssh/dracut-crypt-ssh.git"
SRC_URI=""

LICENSE="GPL2"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="sys-kernel/dracut"
RDEPEND="${DEPEND}
	|| (
		net-misc/connman
		net-misc/dhcp[client]
		net-misc/dhcpcd
		net-misc/netifrc
		net-misc/networkmanager
		sys-apps/systemd
	)
	net-misc/openssh
	sys-apps/util-linux[static-libs]
	net-misc/dropbear"


PATCHES=( "${FILESDIR}/00000000-flush_netifs_ipcfg_on_dropbear_stop.patch" )

DOCS=( "README.md" )
