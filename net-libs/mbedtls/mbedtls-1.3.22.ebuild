EAPI=7

inherit multilib cmake-utils multilib-minimal

DESCRIPTION="Cryptographic library for embedded systems"
HOMEPAGE="http://tls.mbed.org/"
SRC_URI="https://github.com/ARMmbed/mbedtls/archive/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0/8"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~mips ~ppc ~ppc64 ~s390 ~sparc ~x86 ~amd64-fbsd ~x86-fbsd"
IUSE="cpu_flags_x86_sse2 doc havege programs test threads zlib"

RDEPEND="
	!net-libs/polarssl
	programs? ( dev-libs/openssl:0 )
	zlib? ( >=sys-libs/zlib-1.2.8-r1[${MULTILIB_USEDEP}] )"
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen media-gfx/graphviz )
	test? ( dev-lang/perl )"

RESTRICT="mirror"

S="${WORKDIR}/mbedtls-${P}"

enable_mbedtls_option() {
	local myopt="$@"
	# check that config.h syntax is the same at version bump
	sed -i \
		-e "s://#define ${myopt}:#define ${myopt}:" \
		include/polarssl/config.h || die
}

src_prepare() {
	default
	use cpu_flags_x86_sse2 && enable_mbedtls_option POLARSSL_HAVE_SSE2
	use zlib && enable_mbedtls_option POLARSSL_ZLIB_SUPPORT
	use havege && enable_mbedtls_option POLARSSL_HAVEGE_C
	use threads && enable_mbedtls_option POLARSSL_THREADING_C
	use threads && enable_mbedtls_option POLARSSL_THREADING_PTHREAD
	cmake-utils_src_prepare
}

multilib_src_configure() {
	local mycmakeargs
	multilib_is_native_abi && \
		mycmakeargs+=( -DENABLE_PROGRAMS=$(usex programs) ) || \
		mycmakeargs+=( -DENABLE_PROGRAMS=OFF )
	mycmakeargs+=( -DENABLE_ZLIB_SUPPORT=$(usex zlib) \
			-DENABLE_TESTING=$(usex test) \
			-DUSE_SHARED_MBEDTLS_LIBRARY=ON \
			-DINSTALL_MBEDTLS_HEADERS=ON \
			-DLIB_INSTALL_DIR="/usr/$(get_libdir)" )
	cmake-utils_src_configure
}

multilib_src_compile() {
	cmake-utils_src_compile
	use doc && multilib_is_native_abi && emake apidoc
}

multilib_src_test() {
	LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:${BUILD_DIR}/library" \
		cmake-utils_src_test
}

multilib_src_install() {
	cmake-utils_src_install
}

multilib_src_install_all() {
	einstalldocs

	use doc && dohtml -r apidoc

	if use programs ; then
		# avoid file collisions with sys-apps/coreutils
		local p e
		for p in "${ED%/}"/usr/bin/* ; do
			if [[ -x "${p}" && ! -d "${p}" ]] ; then
				mv "${p}" "${ED%/}"/usr/bin/polarssl_${p##*/} || die
			fi
		done
		for e in aes hash pkey ssl test ; do
			docinto "${e}"
			dodoc programs/"${e}"/*.c
			dodoc programs/"${e}"/*.txt
		done
	fi
}
