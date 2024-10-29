### User-defined Wine version variables ###

#example: devel, staging, or stable (wine-staging 4.5+ requires libfaudio0:i386)
branch="devel"

#example: "9.20"
version="9.20"

#example: debian, ubuntu
id="debian"

#example (for debian): bullseye, buster, jessie, wheezy, ${VERSION_CODENAME}, etc
dist="bookworm"

#example: -1 (some wine .deb files have -1 tag on the end and some don't)
tag="-1"

# configuration for wine package

# NOTE: comment the LINK?? will disable all packages
# uncomment to enable packages

# 64-bit version
export LINK64="https://dl.winehq.org/wine-builds/${id}/dists/${dist}/main/binary-amd64"
export DEB64_WINE="wine-${branch}-amd64_${version}~${dist}${tag}_amd64.deb"
export DEB64_TOOLS="wine-${branch}_${version}~${dist}${tag}_amd64.deb"
#export DEB64_DOCS="winehq-${branch}_${version}~${dist}${tag}_amd64.deb"

# 32-bit version
export LINK32="https://dl.winehq.org/wine-builds/${id}/dists/${dist}/main/binary-i386"
export DEB32_WINE="wine-${branch}-i386_${version}~${dist}${tag}_i386.deb"
#export DEB32_TOOLS="wine-${branch}_${version}~${dist}${tag}_i386.deb"
#export DEB32_DOCS="winehq-${branch}_${version}~${dist}${tag}_i386.deb"
