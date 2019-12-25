EAPI=7

EGO_PN="github.com/openshift/origin"

inherit bash-completion-r1 golang-build golang-vcs-snapshot

DESCRIPTION="OpenShift Command-Line Interface"
HOMEPAGE="https://www.openshift.org"
SRC_URI="https://github.com/openshift/origin/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="bash-completion"
RESTRICT="mirror"

RDEPEND="bash-completion? ( >=app-shells/bash-completion-2.3-r1 )"

src_compile() {
	EGO_PN="${EGO_PN}/cmd/oc" \
	EGO_BUILD_FLAGS="-linkshared" \
	golang-build_src_compile

	PERMISSIVE_GO=y \
		OS_GIT_VERSION='' \
		OS_GIT_COMMIT='' \
		OS_GIT_MAJOR='' \
		OS_GIT_MINOR='' \
		OS_GIT_TREE_STATE='' \
		src/${EGO_PN}/hack/generate-docs.sh || die
}

src_install() {
	dobin oc

	pushd src/${EGO_PN} || die
	doman docs/man/man1/oc*
	use bash-completion && dobashcomp contrib/completions/bash/oc
	popd || die
}
