# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit autotools base bzr

DESCRIPTION="Hybris is a solution that allows the use of bionic-based HW adaptations in glibc systems."
EBZR_REVISION="53"
EBZR_REPO_URI="lp:ubuntu/libhybris"

HOMEPAGE=""

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~arm"
IUSE=""

RDEPEND="${DEPEND}"
DEPEND="dev-cpp/gflags
    dev-cpp/glog
    media-libs/mesa[hybris]
    sys-apps/dbus
    dev-util/android-headers
"

S="${WORKDIR}/${PN}-${PV}"

src_prepare() {

    cd "${S}/hybris"
    eautoreconf
}

src_configure() {
    cd "${S}/hybris"
    econf \
	--enable-arch=arm \
	--with-android-headers=/usr/armv7a-hardfloat-linux-gnueabi/usr/include/android
}
