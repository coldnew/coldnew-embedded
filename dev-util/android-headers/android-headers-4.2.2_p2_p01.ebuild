# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit autotools base bzr

DESCRIPTION="Android Platform Headers from AOSP releases."
EBZR_REVISION="12"
EBZR_REPO_URI="lp:~ubuntu-core-dev/libhybris/android-headers"

HOMEPAGE="https://code.launchpad.net/~ubuntu-core-dev/libhybris/android-headers"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~arm"
IUSE=""

RDEPEND="${DEPEND}"
DEPEND=""

S="${WORKDIR}/"

src_install() {
    cd "${S}"

    mv "${PN}-${PV}" "android"

    # pkgconfig file
    insinto /usr/lib/pkgconfig
    newins android/debian/android-headers.pc android-headers.pc

    # remove unuse files
    rm -rf android/debian

    doheader -r android
}
