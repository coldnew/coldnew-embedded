# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit autotools base bzr

DESCRIPTION="Android Debug Bridge CLI tool"
EBZR_REVISION="30"
EBZR_REPO_URI="lp:ubuntu/android-tools"

HOMEPAGE="http://developer.android.com/guide/developing/tools/adb.html"

# The entire source code is Apache-2.0, except for fastboot which is BSD.
LICENSE="Apache-2.0 BSD"

SLOT="0"
KEYWORDS="~arm"
IUSE=""

RDEPEND="sys-libs/zlib:=
    dev-libs/openssl:0="

DEPEND="${RDEPEND}"

S="${WORKDIR}/${PN}-${PV}"

# TODO: Add systemd or sysinit init script

src_prepare() {
    # Apply patches
    epatch "${FILESDIR}/ext4_remove_selinux_support.patch"

    # Copy make file from debian rule
    cp debian/makefiles/adb.mk core/adb/Makefile
    cp debian/makefiles/adbd.mk core/adbd/Makefile
    cp debian/makefiles/fastboot.mk core/fastboot/Makefile
    cp debian/makefiles/ext4_utils.mk extras/ext4_utils/Makefile

    # Remove selinux support
    sed -i 's/\-lselinux//' core/fastboot/Makefile
    sed -i 's/\-lselinux//' extras/ext4_utils/Makefile

    # Make surce use right toolchain
    sed -i "1s/^/CC=$(tc-getCC)\n/" core/adb/Makefile
    sed -i "1s/^/CC=$(tc-getCC)\n/" core/adbd/Makefile
    sed -i "1s/^/CC=$(tc-getCC)\n/" core/fastboot/Makefile
    sed -i "1s/^/CC=$(tc-getCC)\n/" extras/ext4_utils/Makefile

    # Generate simple makefile
    cat << EOF > Makefile

all:
	make -C core/adb
	make -C core/adbd
	make -C core/fastboot
EOF

}

src_install() {
    dobin core/adbd/adbd || die "Install adbd failed"
    dobin core/adb/adb   || die "Install adb failed"
    dobin core/fastboot/fastboot || die "Install fastboot failed"
}
