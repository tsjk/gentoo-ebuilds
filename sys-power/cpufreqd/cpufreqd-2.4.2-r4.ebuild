# $Id$

EAPI="5"

inherit autotools eutils

NVCLOCK_VERSION="0.8b4"

DESCRIPTION="CPU Frequency Daemon"
HOMEPAGE="http://www.linux.it/~malattia/wiki/index.php/Cpufreqd"
SRC_URI="	mirror://sourceforge/${PN}/${P}.tar.bz2
		nvidia? ( http://www.linuxhardware.org/nvclock/nvclock${NVCLOCK_VERSION}.tar.gz )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"

IUSE="acpi apm lm_sensors nforce2 nvidia pmu"
RDEPEND="	sys-fs/sysfsutils
		sys-power/cpupower
		lm_sensors? ( >sys-apps/lm_sensors-3 )"
DEPEND="sys-apps/sed
	${RDEPEND}"
RESTRICT="mirror"

DOCS=( AUTHORS ChangeLog NEWS README TODO )

src_prepare() {
	epatch "${FILESDIR}"/${PN}-conf.d.patch
	epatch "${FILESDIR}"/${PN}-PATH_MAX.patch #318287
	epatch "${FILESDIR}"/${PN}-cpupower.patch
	epatch "${FILESDIR}"/${PN}-acpi_battery.patch

	if use nvidia; then
		cd "${WORKDIR}/nvclock${NVCLOCK_VERSION}"
		epatch "${FILESDIR}/nvclock${NVCLOCK_VERSION}-fpic.patch"
	fi

	epatch_user

	eautoreconf
}

src_configure() {
	local config

	if use nvidia; then
		cd "${WORKDIR}/nvclock${NVCLOCK_VERSION}" || die 'cd to nvclock dir failed'
		econf \
			--disable-gtk \
			--disable-qt \
			--disable-nvcontrol
		emake -j1
		config="--enable-nvclock=${WORKDIR}/nvclock${NVCLOCK_VERSION}"
	fi

	cd "${S}" || die 'cd to source dir failed'
	econf \
		$(use_enable acpi) \
		$(use_enable apm) \
		$(use_enable lm_sensors sensors) \
		$(use_enable nforce2) \
		$(use_enable pmu) \
		${config}
}

src_install() {
	default
	prune_libtool_files --all
	newinitd "${FILESDIR}"/${PN}-init.d ${PN}
}

pkg_postinst() {
	if [ -f "${ROOT}"/etc/conf.d/cpufreqd ] ; then
		ewarn "An old \"/etc/conf.d/cpufreqd\" file was found. It breaks"
		ewarn "the new init script! Please remove it."
		ewarn "# rm /etc/conf.d/cpufreqd"
	fi
}
