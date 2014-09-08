# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/go-mtpfs/go-mtpfs-9999.ebuild,v 1.5 2014/01/28 01:13:50 zerochaos Exp $

EAPI=5

inherit flag-o-matic toolchain-funcs

DESCRIPTION="a simple FUSE filesystem for mounting Android devices as a MTP device"
HOMEPAGE="https://github.com/hanwen/go-mtpfs"
SRC_URI=""

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE=""

COMMON_DEPEND="virtual/libusb
		virtual/udev"
DEPEND="${COMMON_DEPEND}
	dev-libs/go-fuse
	dev-lang/go
	media-libs/libmtp"

RDEPEND="${COMMON_DEPEND}"

src_unpack() {
	mkdir -p "${S}"
	GOPATH="${S}" go get -d -v github.com/hanwen/go-mtpfs
}

src_compile() {
	mkdir -p "${S}"
	GOPATH="${S}" go build -ldflags '-extldflags=-fno-PIC' -v -x github.com/hanwen/go-mtpfs
}

src_install() {
	dobin "go-mtpfs"
}
