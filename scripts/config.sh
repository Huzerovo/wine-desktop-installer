### User-defined Wine version variables ###

#example: devel, staging, or stable (wine-staging 4.5+ requires libfaudio0:i386)
branch_64="devel"
branch_32="devel"

#example: "9.20"
version_64="9.20"
version_32="7.6"

#example: debian, ubuntu
id="debian"

#example (for debian): bullseye, buster, jessie, wheezy, ${VERSION_CODENAME}, etc
dist="bookworm"

#example: -1 (some wine .deb files have -1 tag on the end and some don't)
tag_64="-1"
tag_32="-1"

# configuration for wine package

# NOTE: comment the LINK?? will disable all packages
# uncomment to enable packages

# 64-bit version
#export LINK64="https://dl.winehq.org/wine-builds/${id}/dists/${dist}/main/binary-amd64"
export DEB64_WINE="wine-${branch_64}-amd64_${version_64}~${dist}${tag_64}_amd64.deb"
export DEB64_TOOLS="wine-${branch_64}_${version_64}~${dist}${tag_64}_amd64.deb"
#export DEB64_DOCS="winehq-${branch}_${version}~${dist}${tag}_amd64.deb"

# 32-bit version
export LINK32="https://dl.winehq.org/wine-builds/${id}/dists/${dist}/main/binary-i386"
export DEB32_WINE="wine-${branch_32}-i386_${version_32}~${dist}${tag_32}_i386.deb"
export DEB32_TOOLS="wine-${branch_32}_${version_32}~${dist}${tag_32}_i386.deb"
#export DEB32_DOCS="winehq-${branch_32}_${version_32}~${dist}${tag_32}_i386.deb"
