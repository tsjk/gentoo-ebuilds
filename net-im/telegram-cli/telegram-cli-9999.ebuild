EAPI=8

EGIT_REPO_URI="https://github.com/kenorb-contrib/tg.git"
EGIT_BRANCH="master"
EGIT_HAS_SUBMODULES=1

inherit git-r3

IUSE="json lua python"
DESCRIPTION="Command line interface client for Telegram"
HOMEPAGE="https://github.com/vysheng/tg"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""

DEPEND="sys-libs/zlib
	sys-libs/readline
	dev-libs/libconfig
	dev-libs/openssl
	dev-libs/libevent
	json? ( dev-libs/jansson )
	lua? ( dev-lang/lua )
	python? ( dev-lang/python )"

src_unpack() {
	git-r3_src_unpack
	cd $EGIT_SOURCEDIR
	git submodule update --init --recursive
}

src_configure() {
	econf $(use_enable json json ) \
		$(use_enable lua liblua ) \
		$(use_enable python python )
}

src_install() {
	newbin bin/telegram-cli telegram-cli

	insinto /etc/telegram-cli/
	newins tg-server.pub server.pub
}
