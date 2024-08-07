EAPI=8
inherit gnome2

DESCRIPTION="An editor to the GNOME config system"
HOMEPAGE="https://gitlab.gnome.org/Archive/gconf-editor"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~ia64 ~ppc ~ppc64 ~sparc x86 ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND="
	>=x11-libs/gtk+-3.0.0:3
	>=gnome-base/gconf-2.12:2
"
DEPEND="${RDEPEND}
	sys-devel/gettext
	app-text/gnome-doc-utils
	>=dev-util/intltool-0.35
	virtual/pkgconfig
	~app-text/docbook-xml-dtd-4.1.2
"
# gnome-common for eautoreconf

PATCHES=(
	# Fix assertion failed crash (from 'master')
	"${FILESDIR}/${PN}-3.0.1-assertion-crash.patch"

	# Drop use GTK accel maps (from 'master')
	"${FILESDIR}/${PN}-3.0.1-drop-accel.patch"
)
