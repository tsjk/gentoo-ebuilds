# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

LUA_COMPAT=( luajit )

CRATES="
	ahash@0.8.11
	aho-corasick@1.1.3
	allocator-api2@0.2.18
	android-tzdata@0.1.1
	android_system_properties@0.1.5
	anes@0.1.6
	ansi-to-tui@3.1.0
	anstyle@1.0.6
	anyhow@1.0.82
	arrayvec@0.7.4
	assert_cmd@2.0.14
	autocfg@1.2.0
	beef@0.5.2
	bitflags@1.3.2
	bitflags@2.5.0
	bstr@1.9.1
	bumpalo@3.16.0
	cassowary@0.3.0
	cast@0.3.0
	castaway@0.2.2
	cc@1.0.96
	cfg-if@1.0.0
	chrono@0.4.38
	ciborium@0.2.2
	ciborium-io@0.2.2
	ciborium-ll@0.2.2
	clap@4.5.4
	clap_builder@4.5.2
	clap_lex@0.7.0
	compact_str@0.7.1
	core-foundation-sys@0.8.6
	criterion@0.5.1
	criterion-plot@0.5.0
	crossbeam@0.8.4
	crossbeam-channel@0.5.12
	crossbeam-deque@0.8.5
	crossbeam-epoch@0.9.18
	crossbeam-queue@0.3.11
	crossbeam-utils@0.8.19
	crossterm@0.27.0
	crossterm_winapi@0.9.1
	crunchy@0.2.2
	darling@0.14.4
	darling_core@0.14.4
	darling_macro@0.14.4
	defer-drop@1.3.0
	deranged@0.3.11
	derive_builder@0.11.2
	derive_builder_core@0.11.2
	derive_builder_macro@0.11.2
	difflib@0.4.0
	dirs-next@2.0.0
	dirs-sys-next@0.1.2
	doc-comment@0.3.3
	either@1.11.0
	equivalent@1.0.1
	erased-serde@0.4.4
	errno@0.3.8
	fnv@1.0.7
	fuzzy-matcher@0.3.7
	gethostname@0.4.3
	getrandom@0.2.14
	half@2.4.1
	hashbrown@0.14.5
	heck@0.4.1
	hermit-abi@0.3.9
	home@0.5.9
	humansize@2.1.3
	iana-time-zone@0.1.60
	iana-time-zone-haiku@0.1.2
	ident_case@1.0.1
	indexmap@2.2.6
	indoc@2.0.5
	is-terminal@0.4.12
	itertools@0.10.5
	itertools@0.12.1
	itoa@1.0.11
	jf@0.6.2
	js-sys@0.3.69
	lazy_static@1.4.0
	libc@0.2.154
	libm@0.2.8
	libredox@0.1.3
	linux-raw-sys@0.4.13
	lock_api@0.4.12
	log@0.4.21
	lru@0.12.3
	lscolors@0.17.0
	lua-src@546.0.2
	luajit-src@210.5.8+5790d25
	memchr@2.7.2
	memoffset@0.6.5
	mime@0.3.17
	mime_guess@2.0.4
	minimal-lexical@0.2.1
	mio@0.8.11
	mlua@0.9.7
	mlua-sys@0.5.2
	natord@1.0.9
	nix@0.24.3
	nix@0.25.1
	nom@7.1.3
	nu-ansi-term@0.50.0
	num-conv@0.1.0
	num-traits@0.2.18
	num_threads@0.1.7
	once_cell@1.19.0
	oorandom@11.1.3
	ordered-float@2.10.1
	parking_lot@0.12.2
	parking_lot_core@0.9.10
	paste@1.0.14
	path-absolutize@3.1.1
	path-dedot@3.1.1
	pin-utils@0.1.0
	pkg-config@0.3.30
	plotters@0.3.5
	plotters-backend@0.3.5
	plotters-svg@0.3.5
	powerfmt@0.2.0
	predicates@3.1.0
	predicates-core@1.0.6
	predicates-tree@1.0.9
	proc-macro2@1.0.81
	quote@1.0.36
	ratatui@0.26.1
	rayon@1.10.0
	rayon-core@1.12.1
	redox_syscall@0.5.1
	redox_users@0.4.5
	regex@1.10.4
	regex-automata@0.4.6
	regex-syntax@0.8.3
	rustc-hash@1.1.0
	rustix@0.38.34
	rustversion@1.0.15
	ryu@1.0.17
	same-file@1.0.6
	scopeguard@1.2.0
	serde@1.0.199
	serde-value@0.7.0
	serde_derive@1.0.199
	serde_json@1.0.116
	serde_yaml@0.9.34+deprecated
	signal-hook@0.3.17
	signal-hook-mio@0.2.3
	signal-hook-registry@1.4.2
	skim@0.10.4
	smallvec@1.13.2
	smawk@0.3.2
	snailquote@0.3.1
	stability@0.1.1
	static_assertions@1.1.0
	strsim@0.10.0
	strum@0.26.2
	strum_macros@0.26.2
	syn@1.0.109
	syn@2.0.60
	term@0.7.0
	termtree@0.4.1
	textwrap@0.16.1
	thiserror@1.0.59
	thiserror-impl@1.0.59
	thread_local@1.1.8
	time@0.3.36
	time-core@0.1.2
	time-macros@0.2.18
	timer@0.2.0
	tinytemplate@1.2.1
	tui-input@0.8.0
	tuikit@0.5.0
	unicase@2.7.0
	unicode-ident@1.0.12
	unicode-linebreak@0.1.5
	unicode-segmentation@1.11.0
	unicode-width@0.1.12
	unicode_categories@0.1.1
	unsafe-libyaml@0.2.11
	utf8parse@0.2.1
	version_check@0.9.4
	vte@0.11.1
	vte_generate_state_changes@0.1.1
	wait-timeout@0.2.0
	walkdir@2.5.0
	wasi@0.11.0+wasi-snapshot-preview1
	wasm-bindgen@0.2.92
	wasm-bindgen-backend@0.2.92
	wasm-bindgen-macro@0.2.92
	wasm-bindgen-macro-support@0.2.92
	wasm-bindgen-shared@0.2.92
	web-sys@0.3.69
	which@6.0.1
	winapi@0.3.9
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-util@0.1.8
	winapi-x86_64-pc-windows-gnu@0.4.0
	windows-core@0.52.0
	windows-sys@0.48.0
	windows-sys@0.52.0
	windows-targets@0.48.5
	windows-targets@0.52.5
	windows_aarch64_gnullvm@0.48.5
	windows_aarch64_gnullvm@0.52.5
	windows_aarch64_msvc@0.48.5
	windows_aarch64_msvc@0.52.5
	windows_i686_gnu@0.48.5
	windows_i686_gnu@0.52.5
	windows_i686_gnullvm@0.52.5
	windows_i686_msvc@0.48.5
	windows_i686_msvc@0.52.5
	windows_x86_64_gnu@0.48.5
	windows_x86_64_gnu@0.52.5
	windows_x86_64_gnullvm@0.48.5
	windows_x86_64_gnullvm@0.52.5
	windows_x86_64_msvc@0.48.5
	windows_x86_64_msvc@0.52.5
	winsafe@0.0.19
	xdg@2.5.2
	zerocopy@0.7.32
	zerocopy-derive@0.7.32
"

inherit cargo desktop lua-single xdg-utils

DESCRIPTION="A hackable, minimal, fast TUI file explorer"
HOMEPAGE="https://github.com/sayanarijit/xplr"
SRC_URI="
	https://github.com/sayanarijit/xplr/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	${CARGO_CRATE_URIS}
"
RESTRICT="mirror"

LICENSE="MIT"
# Dependent crate licenses
LICENSE+=" Apache-2.0 GPL-3 MIT MPL-2.0 Unicode-DFS-2016"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc"

REQUIRED_USE="${LUA_REQUIRED_USE}"
RDEPEND="
	${LUA_DEPS}
"
DEPEND="
	${RDEPEND}
"

QA_FLAGS_IGNORED="usr/bin/xplr"

pkg_setup() {
	rust_pkg_setup
}

src_prepare() {
	sed -i Cargo.toml -e "s/'vendored', //" || die
	# for dynamic linking with lua
	default
}

src_configure() {
	cargo_src_configure --bin xplr
}

src_compile() {
	cargo_src_compile
}

src_install() {
	dodoc README.md

	dobin target/$(usex debug debug release)/xplr
	newicon -s 16 assets/icon/${PN}16.png ${PN}.png
	newicon -s 32 assets/icon/${PN}32.png ${PN}.png
	newicon -s 64 assets/icon/${PN}64.png ${PN}.png
	newicon -s 128 assets/icon/${PN}128.png ${PN}.png
	doicon -s scalable assets/icon/${PN}.svg
	domenu assets/desktop/xplr.desktop
}

pkg_postinst() {
	xdg_icon_cache_update
	xdg_desktop_database_update
}

pkg_postrm() {
	xdg_icon_cache_update
	xdg_desktop_database_update
}