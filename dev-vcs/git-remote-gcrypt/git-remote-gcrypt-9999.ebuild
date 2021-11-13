EAPI=7
inherit git-r3

DESCRIPTION="A git remote helper for GPG-encrypted remotes."
HOMEPAGE="https://github.com/spwhitton/git-remote-gcrypt"
SRC_URI=""
EGIT_REPO_URI="https://github.com/spwhitton/${PN}.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="app-crypt/gnupg
        dev-vcs/git"
RDEPEND="${DEPEND}"

src_install()
{
	DESTDIR="${ED}" prefix="${EPREFIX}/usr" ./install.sh && \
		gunzip "${ED}/usr/share/man/man1/git-remote-gcrypt.1.gz" || die "Install failed."
	dodoc CHANGELOG || die "dodoc CHANGELOG failed."
	dodoc README.rst || die "dodoc README.rst failed."
}
