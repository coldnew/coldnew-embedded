# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit bzr cmake-utils

DESCRIPTION="A simple convenience library for handling processes in C++11."

EBZR_REVISION="49"
EBZR_REPO_URI="lp:process-cpp"
HOMEPAGE="https://launchpad.net/process-cpp"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~arm"
IUSE=""

RDEPEND="dev-libs/boost:="

DEPEND="${RDEPEND}
        dev-cpp/gtest
        dev-cpp/gmock"

S="${WORKDIR}/${PN}-${PV}"

# FIXME: build failed due to source can't find header, which also
# belong to this package, wtf!!!

src_configure() {
    cd "${S}"

    local mycmakeargs=(${mycmakeargs}
        -DGTEST_INSTALL_DIR=${SYSROOT}/usr/src/gmock/gtest/include
        -DLIBXML2_INCLUDE_DIR=${SYSROOT}/usr/include/libxml2
    	)

    cmake-utils_src_configure
}
