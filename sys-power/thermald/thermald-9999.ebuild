# $Id$
EAPI=7

AUTOTOOLS_AUTORECONF=1
AUTOTOOLS_IN_SOURCE_BUILD=1

inherit autotools flag-o-matic git-r3 out-of-source systemd

DESCRIPTION="Thermal daemon for Intel architectures"
HOMEPAGE="https://01.org/linux-thermal-daemon"
EGIT_REPO_URI="https://github.com/01org/thermal_daemon.git"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS=""
IUSE=""

RESTRICT="mirror"

RDEPEND="
	dev-libs/dbus-glib:=
	dev-libs/glib:=
	dev-libs/libxml2:=
	sys-apps/dbus:="
DEPEND="${RDEPEND}
	dev-util/glib-utils
	dev-util/gtk-doc
	dev-util/gtk-doc-am
	sys-power/upower"

DOCS=( thermal_daemon_usage.txt README.txt )

src_prepare() {
	default
	eautoreconf
}

my_src_configure() {
	# bug 618948
	append-cxxflags -std=c++14

	ECONF_SOURCE="${S}" econf \
		--with-systemdsystemunitdir="$(systemd_get_systemunitdir)"
}

my_src_install_all() {
	einstalldocs

	rm -rf "${ED}"/etc/init || die
	doinitd "${FILESDIR}"/thermald
}
