EAPI=8

inherit desktop unpacker xdg-utils

DESCRIPTION="Gossip is a desktop client for NOSTR"
HOMEPAGE="https://github.com/mikedilger/gossip"
SRC_URI="https://github.com/mikedilger/gossip/releases/download/v${PV}/${PN%-bin}_${PV}-1_amd64.deb"

LICENSE="GPLv3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="
	>=sys-libs/glibc-2.29
"

RESTRICT="mirror strip"

QA_PREBUILT="usr/bin/gossip"

S="${WORKDIR}"

src_unpack() {
	unpack_deb "${A}"
}

src_compile() {
	:
}

src_install() {
	dodoc usr/share/doc/gossip/copyright
	dobin usr/bin/gossip
	domenu usr/share/applications/gossip.desktop
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_icon_cache_update
	xdg_mimeinfo_database_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_icon_cache_update
	xdg_mimeinfo_database_update
}
