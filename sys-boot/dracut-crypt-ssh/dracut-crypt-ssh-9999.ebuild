EAPI=6

inherit autotools eutils git-r3

DESCRIPTION="dracut initramfs module to start dropbear sshd during boot to enter LUKS passphrase remotely."
HOMEPAGE="https://github.com/dracut-crypt-ssh/dracut-crypt-ssh"
EGIT_REPO_URI="git://github.com/dracut-crypt-ssh/dracut-crypt-ssh.git"
SRC_URI=""

LICENSE="GPL2"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="	net-misc/dhcp[client]
		net-misc/dropbear
		net-misc/openssh
		sys-apps/util-linux[static-libs]
		sys-kernel/dracut"


PATCHES=( "${FILESDIR}/00000000-flush_netifs_ipcfg_on_dropbear_stop.patch" )
