EAPI="6"
inherit bash-completion-r1 eutils git-r3

SLOT="0"
DESCRIPTION="A shell wrapper for mpv/MPlayer to watch videos easy via CLI."
HOMEPAGE="https://github.com/deterenkelt/watchsh"
EGIT_REPO_URI="git://github.com/deterenkelt/watchsh.git"
#SRC_URI="https://github.com/deterenkelt/watchsh/archive/v${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="GPL-3"
MERGE_TYPE="binary"
KEYWORDS="~*"

IUSE="bash-completion convtojpeg +figlet +parallel +pngcrush +remember-delays toilet +xdg-open"

RDEPEND="|| ( media-video/mpv media-video/mplayer2 media-video/mplayer )
		 >=sys-apps/grep-2.9
		 >=sys-apps/sed-4.2.1
		 >=sys-apps/file-5.17
		 >=sys-apps/util-linux-2.20
		 >=app-shells/bash-4.4
		 net-misc/wget
		 remember-delays? ( media-video/mpv
		                    sys-fs/inotify-tools
		                    sys-process/procps
		                    sys-process/psmisc )
		 convtojpeg? ( media-libs/netpbm
		               media-libs/libjpeg-turbo )
		 figlet? ( app-misc/figlet )
		 parallel? ( sys-process/parallel )
		 pngcrush? ( media-gfx/pngcrush )
		 toilet? ( app-misc/toilet )
		 xdg-open? ( x11-misc/xdg-utils )"

S="${WORKDIR}/${P}/sources"

src_prepare() {
	eapply_user
}

src_install() {
	mkdir -p ${D}/usr/{bin,share/{doc/${PN},man/man1,bash-completion/completions}}
	emake DESTDIR="${D}" install || die "make install failed"
	rm -fr "${D}/usr/share/bash-completion"
	use bash-completion && newbashcomp "bash_completion.sh" "${PN}"
}
