# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CMAKE_WARN_UNUSED_CLI=no
inherit git-r3 cmake-utils bash-completion-r1

DESCRIPTION="Command line interface to LastPass.com. [Fork of the LogMeIn Lastpass CLI client. (c) 2014-2019 LastPass. (c) 2020-present Contributers.]"
HOMEPAGE="https://github.com/lastpass-cli-fork/lastpass-cli"
EGIT_REPO_URI="https://github.com/lastpass-cli-fork/lastpass-cli"

SLOT="0"
LICENSE="GPL-2+ GPL-2+-with-openssl-exception"
KEYWORDS="amd64 x86"
IUSE="libressl X +pinentry test"
RESTRICT="!test? ( test )"

RDEPEND="
	X? ( || ( x11-misc/xclip x11-misc/xsel ) )
	!libressl? ( dev-libs/openssl:0= )
	libressl? ( dev-libs/libressl:0= )
	net-misc/curl
	dev-libs/libxml2
	pinentry? ( app-crypt/pinentry )
"
DEPEND="${RDEPEND}
	virtual/pkgconfig
"

src_configure() {
	local mycmakeargs=(
		-DBASH_COMPLETION_COMPLETIONSDIR="$(get_bashcompdir)"
	)

	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile all doc-man $(usex test lpass-test '')
}

src_install() {
	cmake-utils_src_install install

	doman "${BUILD_DIR}"/lpass.1

	# Version 1.3.2 uses automagic detection for bashcomp
	# To preserve backwards compatibility, we unconditionally
	# install the completion file
	newbashcomp contrib/lpass_bash_completion lpass
}

src_test() {
	local myctestargs=(
		-j1 # Parallel tests fail
	)

	# The path to lpass-test is hardcoded to "${S}"/build/lpass-test
	# which is incorrect for our out-of-source build
	sed -e "s|TEST_LPASS=.*|TEST_LPASS=\"${BUILD_DIR}/lpass-test\"|" \
		-i "${S}"/test/include.sh || die

	cmake-utils_src_test
}
