# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit autotools base bzr qt5-build

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
    qt5-build_src_configure
}
