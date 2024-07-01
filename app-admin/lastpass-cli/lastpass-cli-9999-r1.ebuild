EAPI=8

CMAKE_WARN_UNUSED_CLI=no
inherit bash-completion-r1 cmake flag-o-matic git-r3

DESCRIPTION="Command line interface to LastPass.com."
HOMEPAGE="https://github.com/lastpass/lastpass-cli"
EGIT_REPO_URI="https://github.com/lastpass/lastpass-cli"

SLOT="0"
LICENSE="GPL-2+ GPL-2+-with-openssl-exception"
KEYWORDS="amd64 x86"
IUSE="X +pinentry test"
RESTRICT="mirror !test? ( test )"

RDEPEND="
	X? ( || ( x11-misc/xclip x11-misc/xsel ) )
	dev-libs/openssl:0=
	net-misc/curl
	dev-libs/libxml2
	pinentry? ( app-crypt/pinentry )
"
DEPEND="${RDEPEND}
	app-text/asciidoc
	virtual/pkgconfig
"

src_configure() {
	local mycmakeargs=(
		-DBASH_COMPLETION_COMPLETIONSDIR="$(get_bashcompdir)"
	)

	append-cflags -Wno-deprecated-declarations
	cmake_src_configure
}

src_compile() {
	cmake_src_compile all doc-man $(usex test lpass-test '')
}

src_install() {
	cmake_src_install install

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

	cmake_src_test
}
