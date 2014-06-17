# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

QT5_MODULE="qtbase"

inherit qt5-build

DESCRIPTION="The Qt toolkit is a comprehensive C++ application development framework"

if [[ ${QT5_BUILD_TYPE} == live ]]; then
	KEYWORDS=""
else
	KEYWORDS="~arm"
fi

IUSE=""

DEPEND="
	~dev-qt/qtcore-${PV}[debug=]
	~dev-qt/qtgui-${PV}[debug=]
"
RDEPEND="${DEPEND}"

QT5_TARGET_SUBDIRS=(
# for crossbuild
# TODO: build this in qtcore
	src/tools/bootstrap
# ori
	src/tools/uic
	src/widgets
	src/plugins/accessible
)

PATCHES=(
	# bug 511388
	"${FILESDIR}/0001-Ensure-the-QMenu-is-polished-before-creating-the-nat.patch"
)
