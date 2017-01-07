# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit oasis

OASIS_BUILD_DOCS=1
DESCRIPTION="A simple OCaml client for Google Services"
HOMEPAGE="http://gapi-ocaml.forge.ocamlcore.org/"
SRC_URI="http://forge.ocamlcore.org/frs/download.php/1657/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc test"
RESTRICT="mirror"

RDEPEND=">=dev-lang/ocaml-3.12:=
	>=dev-ml/cryptokit-1.3.14:=
	>=dev-ml/extlib-1.5.1:=
	>=dev-ml/findlib-1.2.7:=
	>=dev-ml/ocurl-0.5.3:=
	>=dev-ml/ocamlnet-3.5.1:=
	>=dev-ml/yojson-1.0.2:=
	>=dev-ml/xmlm-1.0.2:="
DEPEND="${RDEPEND}
	test? ( >=dev-ml/ounit-1.1.0
		>=dev-ml/pa_monad-6.0 )"
DOCS=( "README.md" )
