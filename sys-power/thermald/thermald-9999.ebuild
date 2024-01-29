EAPI=8

AUTOTOOLS_AUTORECONF=1
AUTOTOOLS_IN_SOURCE_BUILD=1

inherit autotools flag-o-matic git-r3 out-of-source systemd

DESCRIPTION="Thermal daemon for Intel architectures"
HOMEPAGE="https://01.org/linux-thermal-daemon"
EGIT_REPO_URI="https://github.com/intel/thermal_daemon.git"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS=""
IUSE=""

RESTRICT="mirror"

RDEPEND="
	dev-libs/dbus-glib:=
	dev-libs/glib:=
	dev-libs/libxml2:=
	dev-libs/libevdev
	sys-power/upower
	sys-apps/dbus:="
DEPEND="${RDEPEND}
	dev-build/gtk-doc-am
	dev-util/gtk-doc
	dev-util/glib-utils"

DOCS=( thermal_daemon_usage.txt README.txt )

CONFIG_CHECK="~PERF_EVENTS_INTEL_RAPL ~X86_INTEL_PSTATE ~INTEL_POWERCLAMP ~INT340X_THERMAL ~ACPI_THERMAL_REL ~INT3406_THERMAL"

src_prepare() {
	sed -i -e '/tdrundir/s@\$localstatedir/run@\$runstatedir@' \
		configure.ac || die

	sed -i -e 's@\$(AM_V_GEN) glib-compile-resources@cd \$(top_srcdir) \&\& &@' \
		Makefile.am || die

	default
	eautoreconf
}

my_src_configure() {
	# bug 618948
	append-cxxflags -std=c++14

	ECONF_SOURCE="${S}" econf \
		--disable-werror \
		--runstatedir="${EPREFIX}"/run \
		--with-dbus-power-group=wheel \
		--with-systemdsystemunitdir="$(systemd_get_systemunitdir)"
}

my_src_install_all() {
	einstalldocs

	rm -rf "${ED}"/etc/init || die
	doinitd "${FILESDIR}"/thermald
}
