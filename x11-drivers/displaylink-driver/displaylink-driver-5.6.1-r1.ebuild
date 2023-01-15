# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit systemd udev

DESCRIPTION="DisplayLink USB Graphics Software"
HOMEPAGE="http://www.displaylink.com/downloads/ubuntu"
SRC_URI="${P}.zip"
LICENSE="DisplayLink-EULA"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86 "
IUSE="systemd"
PV_EXTRA="59.184"

QA_PREBUILT="/opt/displaylink/DisplayLinkManager"
RESTRICT="fetch bindist"

DEPEND="app-admin/chrpath
	app-arch/unzip"
RDEPEND=">=sys-devel/gcc-9.2.0
	|| ( =x11-drivers/evdi-1.12* =x11-drivers/evdi-9999 )
	virtual/libusb:1
	>=x11-base/xorg-server-1.17.0
	!systemd? ( sys-auth/elogind )"

pkg_nofetch() {
	einfo "Please download DisplayLink USB Graphics Software for Ubuntu${PV}-EXE.zip from"
	einfo "http://www.displaylink.com/downloads/ubuntu"
	einfo "and rename it to ${P}.zip"
}

src_unpack() {
	default
	sh "${WORKDIR}/${PN}-${PV}-${PV_EXTRA}".run --noexec --target "${P}" || die "src_unpack() failed"
}

src_install() {
	if [[ "${ARCH}" == "arm" ]]; then
		DLM="${S}/arm-linux-gnueabihf/DisplayLinkManager"
	elif [[ "${ARCH}" == "arm64" ]]; then
		DLM="${S}/aarch64-linux-gnu/DisplayLinkManager"
	else
		MY_UBUNTU_VERSION=16.04
		case "${ARCH}" in
			amd64)	MY_ARCH="x64" ;;
			*)	MY_ARCH="${ARCH}" ;;
		esac
		einfo "Using package for Ubuntu ${MY_UBUNTU_VERSION} ${MY_ARCH}"
		DLM="${S}/${MY_ARCH}-ubuntu-${MY_UBUNTU_VERSION//\./}/DisplayLinkManager"
	fi

	dodir /opt/displaylink
	exeinto /opt/displaylink
	chrpath -d "${DLM}"
	doexe "${DLM}"
	insinto /opt/displaylink
	doins *.spkg

	udev_dorules "${FILESDIR}/99-displaylink.rules"

	insinto /opt/displaylink
	insopts -m0755
	newins "${FILESDIR}/udev.sh" udev.sh
	newins "${FILESDIR}/pm-displaylink" suspend.sh
	if use systemd; then
		dosym ../../../opt/displaylink/suspend.sh /lib/systemd/system-sleep/displaylink.sh
		systemd_dounit "${FILESDIR}/dlm.service"
	else
		dosym ../../../opt/displaylink/suspend.sh /etc/pm/sleep.d/displaylink.sh
		newinitd "${FILESDIR}/rc-displaylink-1.3" dlm
	fi

	keepdir /var/log/displaylink
}

pkg_postinst() {
	udev_reload

	einfo "The DisplayLinkManager Init is now called dlm"
	einfo ""
	einfo "You should be able to use xrandr as follows:"
	einfo "xrandr --setprovideroutputsource 1 0"
	einfo "Repeat for more screens, like:"
	einfo "xrandr --setprovideroutputsource 2 0"
	einfo "Then, you can use xrandr or GUI tools like arandr to configure the screens, e.g."
	einfo "xrandr --output DVI-1-0 --auto"
}

pkg_postrm() {
	udev_reload
}
