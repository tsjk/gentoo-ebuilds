# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:

EAPI=5

inherit git-r3

DESCRIPTION="A tool to convert systemd unit files to RC initscripts"
HOMEPAGE="https://github.com/pavlix/systemd2rc"
EGIT_REPO_URI="https://github.com/pavlix/systemd2rc.git"
LICENSE="BSD-2"

SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=""
RDEPEND="
	dev-lang/python
"
src_install()
{
	sed -i 's/systemd2openrc/systemd2rc/g' Makefile
	default_src_install
}
