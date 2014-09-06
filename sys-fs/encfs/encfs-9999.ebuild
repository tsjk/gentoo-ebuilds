# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=2
inherit autotools eutils multilib subversion

DESCRIPTION="An implementation of encrypted filesystem in user-space using FUSE"
ESVN_REPO_URI="http://encfs.googlecode.com/svn/branches/1.x/"
ESVN_PROJECT="encfs"
ESVN_BOOTSTRAP="eautoreconf"
HOMEPAGE="http://arg0.net/encfs"
LICENSE="GPL-3"
KEYWORDS=""
SLOT="0"
IUSE="xattr"

RDEPEND=">=dev-libs/boost-1.34
        >=dev-libs/openssl-0.9.7
        >=dev-libs/rlog-1.4
        >=sys-fs/fuse-2.7.0
        sys-libs/zlib"
DEPEND="${RDEPEND}
        dev-lang/perl
        virtual/pkgconfig
        xattr? ( sys-apps/attr )
        sys-devel/gettext"

src_prepare() {
        epatch "${FILESDIR}"/pod2man.patch
}

src_configure() {
        use xattr || export ac_cv_header_attr_xattr_h=no

        econf \
                --disable-dependency-tracking
}

src_install() {
        emake DESTDIR="${D}" install || die
        dodoc AUTHORS ChangeLog README
        find "${D}" -name '*.la' -delete
}
