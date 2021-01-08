EAPI=7

inherit systemd

MY_PKG="devolo-cockpit-v${PV//./-}-linux.run"
DESCRIPTION="Display and configure settings of your devolo device"
HOMEPAGE="https://www.devolo.com/support/downloads/download/devolo-cockpit.html"
SRC_URI="https://www.devolo.com/fileadmin/Web-Content/DE/products/hnw/devolo-cockpit/software/${MY_PKG}"

LICENSE="EULA"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="systemd"
RESTRICT="mirror"

#  dev-util/adobe-air-runtime from steam-overlay
DEPEND="	app-arch/bzip2[abi_x86_32]
		app-arch/xz-utils
		>=dev-libs/nss-3[abi_x86_32]
		dev-libs/libxml2[abi_x86_32]
		>=dev-libs/libxslt-1.1[abi_x86_32]
		~dev-util/adobe-air-runtime-2.6
		gnome-base/libgnome-keyring
		x11-libs/gtk+:2[abi_x86_32]
		x11-libs/libXaw[abi_x86_32]"
RDEPEND="${DEPEND}"

S="${WORKDIR}"

QA_PRESTRIPPED="/opt/devolo/dlancockpit/bin/dlancockpit /usr/bin/devolonetsvc"

src_unpack() {
	local _arch
	use amd64 && _arch="amd64"
	use x86 && _arch="i386"
	local skip=$(grep -a -m1 -n "HERE_BE_DRAG[O]NS" "${DISTDIR}/${MY_PKG}" | cut -d: -f1) || die "Unable to find tar archive position."
	tail "${DISTDIR}/${MY_PKG}" -n +$((skip+1)) | tar -x -C . -f - || die "Unable to untar."
	ar x "devolo-dlan-cockpit_${PV}-0_${_arch}.deb" || die "Unable to unpack debian archive for devolo-dlan-cockpit."
	find . -name "adobeair*${_arch}.deb" -print | xargs ar x || die "Unable to unpack debian archive dor adobe air."
	tar xJf data.tar.xz
	sed -i 's/\.appdata\//~\/\.appdata\//g' "${S}/opt/devolo/dlancockpit/bin/dlancockpit-run.sh"
	echo "StartupWMClass=dlancockpit" >> "${S}/usr/share/applications/devolo-dlan-cockpit.desktop"
}

src_install(){
	cp -ar "${S}/opt" "${S}/usr" "${ED}/"
  	systemd_dounit "${FILESDIR}/devolonetsvc.service"
	printf "<?xml version="1.0" encoding="utf-8"?>\n<data_collection><allowed>2</allowed></data_collection>" > "${S}/config.xml"
	newinitd "${FILESDIR}/devolonetsvc.initd" devolonetsvc
	insinto "/var/lib/devolonetsvc"
	newins "${S}/config.xml" config.xml
	insinto /etc/revdep-rebuild
        echo "SEARCH_DIRS_MASK=\"/opt/devolo/dlancockpit\"" >> ${T}/10${PN}
        echo "SEARCH_DIRS_MASK=\"/usr/bin/devolonetsvc\"" >> ${T}/10${PN}
	doins "${T}"/10${PN} || die
}
