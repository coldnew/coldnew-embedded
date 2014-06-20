# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit autotools base bzr

DESCRIPTION="Maliit Input Method Framework."
EBZR_REVISION="38"
EBZR_REPO_URI="lp:~ubuntu-core-dev/maliit/maliit-framework-ubuntu"

HOMEPAGE="https://code.launchpad.net/~ubuntu-core-dev/maliit/maliit-framework-ubuntu"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~arm"
IUSE=""

RDEPEND="${DEPEND}"
DEPEND=""

S="${WORKDIR}/"

src_install() {
    cd "${S}"

    # mv "${PN}-${PV}" "android"

    # # pkgconfig file
    # insinto /usr/lib/pkgconfig
    # newins android/debian/android-headers.pc android-headers.pc

    # # remove unuse files
    # rm -rf android/debian

    # doheader -r android

    ls -lh
}
