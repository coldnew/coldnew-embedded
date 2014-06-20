# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/gmock/gmock-1.7.0-r1.ebuild,v 1.2 2014/05/04 15:27:38 vapier Exp $

EAPI="4"

inherit libtool cmake-utils

DESCRIPTION="Google's C++ mocking framework"
HOMEPAGE="http://code.google.com/p/googlemock/"
SRC_URI="http://googlemock.googlecode.com/files/${P}.zip"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~arm"
IUSE="static-libs"

RDEPEND="=dev-cpp/gtest-${PV}*"
DEPEND="${RDEPEND}
	app-arch/unzip"

pkg_setup() {
	# Stub to disable python_setup running when USE=-test.
	# We'll handle it down in src_test ourselves.
	:
}

src_unpack() {
	default
	# make sure we always use the system one
	rm -r "${S}"/gtest/{Makefile,configure}* || die
}

src_prepare() {
	sed -i -r \
		-e '/^install-(data|exec)-local:/s|^.*$|&\ndisabled-&|' \
		Makefile.in
	elibtoolize
}

src_configure() {
    local mycmakeargs=("${mycmakeargs}
	-DSIMON_LIB_INSTALL_DIR=/usr/$(get_libdir)
	")
    cmake-utils_src_configure
}

# FIXME: Not a good way to install filesls
# but why can't I use `make install` ?
src_install() {
    cd "${S}_build"

    dolib libgmock.a
    dolib libgmock_main.a
}
