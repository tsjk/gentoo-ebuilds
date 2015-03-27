# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit findlib

DESCRIPTION="A JSON library for OCaml"
HOMEPAGE="http://mjambon.com/yojson.html"
SRC_URI="https://github.com/mjambon/yojson/archive/v1.2.0.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"
RESTRICT="mirror"

DEPEND="dev-lang/ocaml
	dev-ml/easy-format
	dev-ml/biniou
	dev-ml/cppo"
RDEPEND="${DEPEND}"

src_compile() {
	emake -j1
	use doc && emake doc
}

src_install() {
	dodir "/usr/bin"
	findlib_src_preinst
	emake PREFIX="${D}/usr" install
	dodoc README.md Changes
	use doc && dohtml -r doc/
}
