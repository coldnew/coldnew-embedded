# Copyright 2014 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI="5"

DESCRIPTION="List of packages that are needed inside the phablet OS base "

HOMEPAGE=""
LICENSE=""
SLOT="0"
KEYWORDS="*"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}"

################################################################################
## TODO: Core packages but may need to rewrite

RDEPEND+="
 	sys-apps/baselayout
"

################################################################################
## Core packages (toolchain)
RDEPEND+="
	=sys-libs/glibc-2.17
"

################################################################################
## Core packages (init or baseapp)


RDEPEND+="
 	sys-apps/busybox
 	sys-apps/systemd
"

################################################################################
## Package Manager
RDEPEND+="
 	sys-apps/opkg
"

################################################################################
## Linux Container
RDEPEND+="
 	=app-emulation/lxc-1.0.3
 	=app-emulation/lxc-android-config-0.162
"

################################################################################
## Qt5 packages
#RDEPEND+="
# 	=dev-qt/qtcore-5.2.1
#"

################################################################################
## Packages from Phablet
RDEPEND+="
 	dev-util/android-tools
"
