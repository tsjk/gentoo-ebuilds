EAPI=7

inherit autotools git-r3

DESCRIPTION="A FUSE based filesystem that can mount one or multiple RAR archive(s)"
HOMEPAGE="https://hasse69.github.io/rar2fs/ https://github.com/hasse69/rar2fs"
EGIT_REPO_URI="https://github.com/hasse69/${PN}.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE="debug"

# Note that upstream unrar sometimes breaks ABI without updating the SONAME
# version so try rebuilding rar2fs if it doesn't work following an unrar
# upgrade.
RDEPEND=">=app-arch/unrar-5.0:=
	sys-fs/fuse:0"
DEPEND="${RDEPEND}"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	export USER_CFLAGS="${CFLAGS}"

	econf \
		--with-unrar="${ESYSROOT}"/usr/include/libunrar \
		--disable-static-unrar \
		$(use_enable debug)
}
