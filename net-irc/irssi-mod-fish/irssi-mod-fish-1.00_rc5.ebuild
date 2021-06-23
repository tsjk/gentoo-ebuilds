EAPI="7"

inherit multilib toolchain-funcs

MY_PV="${PV/_rc5/-RC5}"
DESCRIPTION="FiSH blowfish encryption irssi module"
HOMEPAGE="http://fish.secure.la/"
SRC_URI="http://fish.secure.la/irssi/FiSH-irssi.v${MY_PV}-source.zip"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="app-crypt/miracl
	net-irc/irssi
	dev-libs/glib"
RDEPEND="net-irc/irssi"

S="${WORKDIR}/FiSH-irssi.v${MY_PV}-source"

src_prepare() {
	sed -i \
		-e "s:/usr/local/:/usr/:g" \
		-e 's:\@echo "Press ENTER to continue or CTRL+C to abort\.\.\."\; read junk::' \
		-e '/miracl.a not found/d' \
		-e "s:DH1080.o miracl.a:DH1080.o /usr/$(get_libdir)/libmiracl.a:g" \
		-e "s:gcc -c -static:$(tc-getCC) -c -static ${CFLAGS}:" \
		-e "s:gcc -static -c:$(tc-getCC) -c -static ${CFLAGS}:" \
		-e "s:gcc -static -shared:$(tc-getCC) -static -shared ${CFLAGS}:" \
		-e "s:gcc -fPIC -shared:$(tc-getCC) -fPIC -shared ${CFLAGS}:" \
		-e "s:gcc -I\. -I\$(glib_dir) -I\$(glib_dir)/include -I\$(glib_dir)/glib -I\$(irssi_dir) -I\$(irssi_dir)/src -I\$(irssi_dir)/src/core -I\$(irssi_dir)/src/fe-common/core -static -O2 -Wall:$(tc-getCC) -static ${CFLAGS} -Wall -I. -I\$(glib_inc) -I\$(glib_inc)/glib -I\$(glib_dir) -I\$(glib_dir)/include -I\$(glib_dir)/glib -I\$(irssi_dir) -I\$(irssi_dir)/src -I\$(irssi_dir)/src/core -I\$(irssi_dir)/src/fe-common/core:" \
		Makefile || die "Failed to update Makefile"
	default
}

src_compile() {
	if use amd64; then
		emake amd64 || die "make failed"
	else
		emake || die "make failed"
	fi
}

src_install() {
	insinto /usr/$(get_libdir)/irssi/modules
	doins libfish.so || die "install failed"
	dodoc FiSH-irssi.txt FiSH-irssi_History.txt blow.ini-EXAMPLE || die "doc failed"
}
