# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

# Declare official file to make qt5-build not download source from wrong place
OFFICIAL_QT_FILE=false

inherit qt5-build bzr

DESCRIPTION="Qt plugins for Ubuntu Application API and Qt Platform Abstraction (QPA)"
EBZR_REVISION="218"
EBZR_REPO_URI="lp:qtubuntu"

HOMEPAGE="https://launchpad.net/qtubuntu"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~arm"
IUSE=""

RDEPEND="${DEPEND}"
DEPEND="dev-cpp/gflags
    media-libs/mesa[hybris]
    dev-util/android-headers
"

S="${WORKDIR}/${PN}-${PV}"

src_configure() {
    cd "${S}"

    # TODO: fix qt5-build eclass

    "${SYSROOT}"/usr/lib/qt5/bin/qmake
     echo "--------------------------------------------"
}
