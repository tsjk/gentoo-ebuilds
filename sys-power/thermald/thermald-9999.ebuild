# $Id$
EAPI=5

AUTOTOOLS_AUTORECONF=1
AUTOTOOLS_IN_SOURCE_BUILD=1
inherit autotools-utils git-r3 systemd

DESCRIPTION="Thermal daemon for Intel architectures"
HOMEPAGE="https://01.org/linux-thermal-daemon"
EGIT_REPO_URI="https://github.com/01org/thermal_daemon.git"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS=""

IUSE=""
RESTRICT="mirror"

CDEPEND="dev-libs/dbus-glib
	dev-libs/libxml2"
DEPEND="${CDEPEND}
	sys-apps/sed"
RDEPEND="${CDEPEND}"

DOCS=( thermal_daemon_usage.txt README.txt )

src_configure() {
	local myeconfargs=(
	--with-systemdsystemunitdir=$(systemd_get_unitdir)
	)
	autotools-utils_src_configure
}

src_install() {
	autotools-utils_src_install
	rm -rf "${D}"/etc/init || die
	doinitd "${FILESDIR}"/thermald
}
