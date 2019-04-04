EAPI="7"

inherit cmake-utils git-r3 toolchain-funcs

DESCRIPTION="FiSH blowfish encryption irssi module"
HOMEPAGE="https://github.com/falsovsky/FiSH-irssi"
EGIT_REPO_URI="https://github.com/falsovsky/FiSH-irssi.git"

LICENSE="as-is"
SLOT="0"
KEYWORDS=""
IUSE=""
DEPEND="	dev-libs/glib:2
		dev-libs/openssl:0
		net-irc/irssi"
RDEPEND="net-irc/irssi"
DOCS=( README README.md )
