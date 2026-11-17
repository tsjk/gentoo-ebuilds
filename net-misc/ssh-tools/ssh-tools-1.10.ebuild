EAPI="8"
EGO_PN="codeberg.org/vaporup"

COMMIT_ID="1c42a683d90a431aae3de9c15f41a4ad274407d8"

inherit go-module

DESCRIPTION="Tools to make ssh more convenient"
HOMEPAGE="
	https://codeberg.org/vaporup/ssh-tools
"
SRC_URI="https://codeberg.org/vaporup/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

# Add the manually vendored tarball.
# 1) Create a tar archive optimized to reproduced by other users or devs.
# 2) Compress the archive using XZ limiting decompression memory for
#    pretty constraint systems.
# Use something like:
# GOMODCACHE="${PWD}"/go-mod go mod download -modcacherw
# tar cf $P-deps.tar go-mod \
#       --mtime="1970-01-01" --sort=name --owner=portage --group=portage
# xz -k -9eT0 --memlimit-decompress=8192M $P-deps.tar
SRC_URI+=" https://ipfs.orbitor.dev/ipfs/bafybeifyow5q7ksgn2xqd6q5khs4v3nbkubvixftegf6waw6dfgn3zlo2mhttps -> ${P}-deps.tar.xz"

S="${WORKDIR}/${PN}"

LICENSE="Apache-2.0 BSD GPL-3 imagemagick MIT"
SLOT="0"
KEYWORDS="~amd64"

# Don't run tests as they check the scripts against
# a single hard-coded SSH server.
RESTRICT="mirror test"

RDEPEND="net-misc/openssh"

QA_PRESTRIPPED="
	usr/bin/ssh-authorized-keys
	usr/bin/ssh-sig
"
DOCS=( "CHANGELOG.md" )

src_compile() {
	export CGO_ENABLED=0
	# Flags -w, -s: Omit debugging information to reduce binary size,
	# see https://golang.org/cmd/link/.
	local mygobuildargs=(
		-ldflags="-X ${EGO_PN}/config.GitCommit=${COMMIT_ID} -s -w"
		-mod mod -v -work -x
	)
	ego build  "${mygobuildargs[@]}" ./cmd/go/ssh-authorized-keys
	ego build  "${mygobuildargs[@]}" ./cmd/go/ssh-sig
}

src_install(){
	default

	doman man/*

	# golang binaries
	dobin ssh-authorized-keys
	dobin ssh-sig

	# perl scripts
	dobin cmd/perl/ssh-last/ssh-last

	# bash scripts
	dobin cmd/bash/ssh-certinfo/ssh-certinfo
	dobin cmd/bash/ssh-diff/ssh-diff
	dobin cmd/bash/ssh-facts/ssh-facts
	dobin cmd/bash/ssh-force-password/ssh-force-password
	dobin cmd/bash/ssh-hostkeys/ssh-hostkeys
	dobin cmd/bash/ssh-keyinfo/ssh-keyinfo
	dobin cmd/bash/ssh-ping/ssh-ping
	dobin cmd/bash/ssh-pwd/ssh-pwd
	dobin cmd/bash/ssh-version/ssh-version
}
