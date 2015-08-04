# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit oasis

OASIS_BUILD_DOCS=1

DESCRIPTION="FUSE filesystem over Google Drive"
HOMEPAGE="http://forge.ocamlcore.org/projects/gdfuse/"
SRC_URI="http://forge.ocamlcore.org/frs/download.php/1520/${P}.tar.gz"
RESTRICT="mirror"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc test"

RDEPEND=">=dev-ml/ocurl-0.5.3:=
	>=dev-ml/ocamlnet-3.3.5:=
	>=dev-ml/cryptokit-1.3.14:=
	>=dev-ml/extlib-1.5.1:=
	>=dev-ml/yojson-1.0.2:=
	>=dev-ml/xmlm-1.0.2:=
	>=dev-ml/gapi-ocaml-0.2.5
	>=dev-ml/ocamlfuse-2.7.1
	>=dev-ml/ocaml-sqlite3-1.6.1"
DEPEND="${RDEPEND}
	test? ( >=dev-ml/ounit-1.1.0
	>=dev-ml/pa_monad-6.0 )"
DOCS=( "README.md" )
