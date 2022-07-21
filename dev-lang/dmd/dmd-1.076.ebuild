EAPI=6

inherit eutils multilib flag-o-matic

MY_P=${P/-/.}

DESCRIPTION="Digital Mars D Compiler"
HOMEPAGE="http://www.digitalmars.com/d/"
SRC_URI="http://ftp.digitalmars.com/${MY_P}.zip"

# License doesn't allow redistribution
LICENSE="DMD"
RESTRICT="mirror"
SLOT="1"
KEYWORDS="~amd64"
IUSE="tools"

DEPEND="sys-apps/findutils
	app-arch/unzip"
RDEPEND=""

S="${WORKDIR}/dmd"

src_prepare() {
	default
	# remove unnecessary files
	rm -r freebsd html osx linux/lib32/* linux/lib64/* \
	linux/bin32/{README.TXT,dmd,dmd.conf} linux/bin64/{README.TXT,dmd,dmd.conf} \
	windows samples README.TXT license.txt || die "something went wrong"

	cd "${S}"/src

	# patch for slot-compatibility
	epatch "${FILESDIR}/${P}-slot-compat.patch"
	# patch for makefile
	epatch "${FILESDIR}/${P}-makefile.patch"

	epatch "${FILESDIR}/${P}-code_fixes.patch"
	has_version '>=sys-libs/glibc-2.26' && epatch "${FILESDIR}/${P}-no_bits_slash_nan_h.patch"

	append-ldflags $(no-as-needed)
}

src_compile() {
	cd "${S}"/src/dmd

	# make dmd
	TARGET_CPU=X86 emake -f posix.mak
	cp dmd idgen impcnvgen optabgen "${S}"/linux/bin32 || die "failed"
	fperms guo=rx ../../linux/bin32/dmd

	# make phobos
	cd "${S}"/src/phobos
	# zlib 1.2.5 will be statically linked
	TARGET_CPU=X86 emake -j1 -f linux.mak "DMD="${S}"/linux/bin32/dmd"
	cp lib32/libphobos.a "${S}"/linux/lib32 || die "failed"

	# Clean up
	emake -f linux.mak clean
	find "${S}" \( -name "*.c" -o -name "*.h" -o -name "*.mak" -o -name "*.txt" \
	-o -name "*.obj" -o -name "*.ddoc" -o -name "*.asm" \) -exec rm -v {} \; || die "failed"
}

src_install() {
	# Lib
	dolib.a linux/lib32/libphobos.a

	# Install dmd compiler
	newbin linux/bin32/dmd dmd1

	# Build new dmd1.conf
	cat > dmd1.conf << END
[Environment]
DFLAGS=-I/usr/include/phobos1 -L-L/usr/$(get_libdir)
END
	insinto /etc
	doins dmd1.conf

	# Includes
	insinto /usr/include/phobos1
	doins -r src/phobos/*

	# Man pages
	newman man/man1/dmd.1 dmd1.1
	newman man/man1/dmd.conf.5 dmd1.conf.5

	if use tools; then
		doman man/man1/dumpobj.1
		doman man/man1/obj2asm.1
		doman man/man1/rdmd.1

		# Tools
		dobin linux/bin32/{dumpobj,obj2asm,rdmd}
	fi
}

pkg_postinst () {
	ewarn "                                                 "
	ewarn "DMD1 uses "dmd1.conf", not "dmd.conf"!           "
	ewarn "                                                 "
}
