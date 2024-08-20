# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Auto-Generated by cargo-ebuild 0.5.4-r1

EAPI=8

CRATES="
	addr2line@0.21.0
	adler@1.0.2
	aho-corasick@1.1.2
	anstream@0.6.11
	anstyle@1.0.5
	anstyle-parse@0.2.3
	anstyle-query@1.0.2
	anstyle-wincon@3.0.2
	anyhow@1.0.79
	backtrace@0.3.69
	bitflags@2.4.2
	bytes@1.5.0
	cc@1.0.83
	cfg-if@1.0.0
	clap@4.4.18
	clap_builder@4.4.18
	clap_derive@4.4.7
	clap_lex@0.6.0
	colorchoice@1.0.0
	env_filter@0.1.0
	env_logger@0.11.1
	errno@0.3.8
	gimli@0.28.1
	heck@0.4.1
	humantime@2.1.0
	libc@0.2.153
	linux-raw-sys@0.4.13
	log@0.4.20
	memchr@2.7.1
	miniz_oxide@0.7.1
	mio@0.8.10
	nix@0.27.1
	object@0.32.2
	passfd@0.1.6
	pin-project-lite@0.2.13
	proc-macro2@1.0.78
	quote@1.0.35
	regex@1.10.3
	regex-automata@0.4.5
	regex-syntax@0.8.2
	rustc-demangle@0.1.23
	rustix@0.38.31
	socket2@0.5.5
	strsim@0.10.0
	syn@2.0.48
	terminal_size@0.3.0
	tokio@1.35.1
	tokio-macros@2.2.0
	unicode-ident@1.0.12
	utf8parse@0.2.1
	wasi@0.11.0+wasi-snapshot-preview1
	windows-sys@0.48.0
	windows-sys@0.52.0
	windows-targets@0.48.5
	windows-targets@0.52.0
	windows_aarch64_gnullvm@0.48.5
	windows_aarch64_gnullvm@0.52.0
	windows_aarch64_msvc@0.48.5
	windows_aarch64_msvc@0.52.0
	windows_i686_gnu@0.48.5
	windows_i686_gnu@0.52.0
	windows_i686_msvc@0.48.5
	windows_i686_msvc@0.52.0
	windows_x86_64_gnu@0.48.5
	windows_x86_64_gnu@0.52.0
	windows_x86_64_gnullvm@0.48.5
	windows_x86_64_gnullvm@0.52.0
	windows_x86_64_msvc@0.48.5
	windows_x86_64_msvc@0.52.0
"

inherit cargo

DESCRIPTION="A tool for running an application in an isolated network namespace, with external network access only through a SOCKS proxy."
# Double check the homepage as the cargo_metadata crate
# does not provide this value so instead repository is used
HOMEPAGE="https://github.com/stevenengler/socksns"
SRC_URI="https://github.com/stevenengler/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	${CARGO_CRATE_URIS}"

# License set may be more restrictive as OR is not respected
# use cargo-license for a more accurate license picture
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="mirror"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

# rust does not use *FLAGS from make.conf, silence portage warning
# update with proper path to binaries this crate installs, omit leading /
QA_FLAGS_IGNORED="usr/bin/${PN}"
