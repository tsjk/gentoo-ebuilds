EAPI=8

inherit git-r3
EGIT_REPO_URI="https://github.com/qca/open-plc-utils.git"
KEYWORDS=""

DESCRIPTION="Qualcomm Atheros Open Powerline Toolkit."
HOMEPAGE="https://github.com/qca/open-plc-utils"

LICENSE="BSD"
SLOT="0"
IUSE="doc"

RDEPEND=""
DEPEND="${RDEPEND}"

S="${WORKDIR}/open-plc-utils-${PV}"

src_install() {
	emake \
		ROOTFS="${D}" \
		BIN="${D}/usr/bin" \
		MAN="${D}/usr/share/man/man1" \
		DOC="${D}/usr/share/doc/${PN}" \
			install || die "emake install failed"
	emake \
		ROOTFS="${D}" \
		BIN="${D}/usr/bin" \
		MAN="${D}/usr/share/man/man1" \
		DOC="${D}/usr/share/doc/${PN}" \
			manuals || die "emake manuals failed"
	use doc && dohtml -r docbook
}
