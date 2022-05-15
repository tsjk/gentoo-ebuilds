EAPI=8

inherit go-module

DESCRIPTION="A simple terminal UI for both docker and docker-compose"
HOMEPAGE="https://github.com/jesseduffield/lazydocker"

SRC_URI="https://github.com/jesseduffield/lazydocker/archive/v${PV}.tar.gz -> ${P}.tar.gz
	${EGO_VENDOR_URI}"
RESTRICT="mirror"

KEYWORDS="~amd64"
LICENSE="MIT"
SLOT="0"

BDEPEND=">=dev-lang/go-1.18"
RDEPEND="app-containers/docker"

EGO_PN="github.com/jesseduffield/lazydocker"

src_compile() {
	GOCACHE="${T}/go-cache" \
		go build -v -work -x -ldflags="-w" "${EGO_PN}" || die
}

src_install() {
	GOCACHE="${T}/go-cache" \
		go install -v -work -x -ldflags="-w" "${EGO_PN}" || die

	dobin ${PN}
	dodoc ./{*.md,Dockerfile,docs/{*.md,keybindings/*.md}}
}
