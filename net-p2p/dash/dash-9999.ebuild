# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="6"

DB_VER="4.8"
inherit autotools db-use eutils fdo-mime flag-o-matic gnome2-utils kde4-functions toolchain-funcs

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI=${EGIT_REPO_URI:-"git://github.com/dashpay/dash.git"}
	KEYWORDS=""
	SRC_URI=""
else
	inherit vcs-snapshot
	KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
	SRC_URI="https://github.com/dashpay/dash/tarball/${PV} -> ${P}.tar.gz"
fi

DESCRIPTION="Dash (DASH) is an open sourced, privacy-centric digital currency with instant transactions."
HOMEPAGE="https://www.dashpay.io/"

LICENSE="MIT"
SLOT="0"
IUSE+="dbus kde qrcode qt4 qt5"

COMMON_DEPEND="
	dev-libs/boost
	>=dev-libs/libsecp256k1-0.0.0_pre20151118
	dev-libs/openssl
	dev-libs/univalue
	net-libs/miniupnpc
	dbus? (
		qt4? ( dev-qt/qtdbus:4 )
		qt5? ( dev-qt/qtdbus:5 )
	)
	qrcode? (
		media-gfx/qrencode
	)
	qt4? ( dev-qt/qtcore:4[ssl] dev-qt/qtgui:4 )
	qt5? (
		dev-qt/assistant:5
		dev-qt/designer:5
		dev-qt/qtgui:5
		dev-qt/linguist:5
		dev-qt/linguist-tools:5
		dev-qt/qtnetwork:5
		dev-qt/pixeltool:5
		dev-qt/qdbus:5
		dev-qt/qdbusviewer:5
		dev-qt/qdoc:5
		dev-qt/qtdbus:5
		dev-qt/qtdiag:5
		dev-qt/qtgui:5
		dev-qt/qtpaths:5
		dev-qt/qtplugininfo:5
		dev-qt/qtwidgets:5
	)
"

DEPEND="
	dev-util/automoc
	media-gfx/qrencode
	sys-devel/autoconf
	sys-devel/automake
	sys-devel/binutils
	sys-devel/gcc
	sys-devel/libtool
	sys-devel/make
	virtual/pkgconfig
	${COMMON_DEPEND}
	qt5? ( dev-qt/linguist-tools:5 )
"

RDEPEND="
	${COMMON_DEPEND}
"

REQUIRED_USE="^^ ( qt4 qt5 )"


#pkg_setup() {
#	local UG=´dash'
#	enewgroup "${UG}"
#	enewuser "${UG}" -1 -1 /var/lib/dash "${UG}"
#}

src_prepare() {
	append-cxxflags "-fPIE -DBOOST_VARIANT_USE_RELAXED_GET_BY_DEFAULT=1"
	if [[ ${PV} == "9999" ]]; then eautoreconf; fi
	default
        rm -r src/leveldb || die
        rm -r src/secp256k1 || die
}

src_configure() {
	econf	--disable-bench  \
		--disable-ccache \
		--disable-static \
		--enable-tests=no \
		$(use_with dbus qtdbus)  \
		--with-gui=$(usex qt5 qt5 qt4) \
		$(use_with qrcode qrencode)  \
		--with-system-libsecp256k1  \
		--with-system-leveldb
		--with-system-univalue
}

src_install() {
	default

	#doexe src/dashd
	#doexe src/dash-cli
	#doexe src/qt/dash-qt

	insinto /etc/dash
	newins "${FILESDIR}/dash.conf" dash.conf
	fowners dash:dash /etc/dash/dash.conf
	fperms 600 /etc/dash/dash.conf

	sed -i 's@BITCOIN@DASH@g' "contrib/init/dashd.openrcconf" "contrib/init/dashd.openrc"
	newconfd "contrib/init/dashd.openrcconf" ${PN}
	newinitd "contrib/init/dashd.openrc" ${PN}
	systemd_dounit "${FILESDIR}/dashd.service"

	keepdir /var/lib/dash/.dash
	fperms 700 /var/lib/dash
	fowners dash:dash /var/lib/dash/
	fowners dash:dash /var/lib/dash/.dash
	dosym /etc/dash/dash.conf /var/lib/dash/.dash/dash.conf

	dodoc COPYING
	dodoc doc/*
	doman contrib/debian/manpages/{dashd.1,dash.conf.5,dash-qt.1}

	insinto /etc/logrotate.d
	newins "${FILESDIR}/dashd.logrotate-r1" dashd

	insinto /usr/share/pixmaps
	newins "share/pixmaps/dash128.png.png" "dashcoin.png"
	make_desktop_entry "${PN} %u" "DASH-Qt" "/usr/share/pixmaps/${PN}.ico" "Qt;Network;P2P;Office;Finance;" "MimeType=x-scheme-handler/bitcoin;\nTerminal=false"

	if use kde; then
		insinto /usr/share/kde4/services
		doins contrib/debian/dash-qt.protocol
	fi
}
