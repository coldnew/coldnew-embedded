# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit  bzr cmake-utils

DESCRIPTION="Development headers for Ubuntu Platform API including Android implementation."
EBZR_REVISION="71"
EBZR_REPO_URI="lp:ubuntu/platform-api"

HOMEPAGE="https://launchpad.net/platform-api"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~arm"
IUSE="hybris"

RDEPEND="dev-libs/boost:="
DEPEND="${RDEPEND}
	app-misc/location-service
	dev-libs/boost
	dev-libs/dbus-cpp
	net-misc/url-dispatcher
	sys-apps/dbus
	hybris? ( media-libs/libhybris )
	"

S="${WORKDIR}/${PN}-${PV}"

src_configure() {
    cd "${S}"

    local mycmakeargs=("${mycmakeargs}
        -DSIMON_LIB_INSTALL_DIR=/usr/$(get_libdir)
	")

    cmake-utils_src_configure

    # Ubuntu's 'pkg-config --cflags ...' outputs 'Requires:' first, and 'Cflags:' last #
    # Gentoo's 'pkg-config --cflags ...' outputs 'Cflags:' first, and 'Requires:' last #
    # Re-order to what the source expects #
    sed -e 's:\(.*\)=\(.*dbus-cpp-0;\)\(.*\):\1=\3;\2:g' \
	-e 's:;$::g' \
	-i "${BUILD_DIR}"/CMakeCache.txt
}
