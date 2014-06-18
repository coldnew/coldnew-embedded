# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit autotools base eutils

DESCRIPTION="Configuration to fire up an ubuntu-touch android container."
HOMEPAGE="https://launchpad.net/ubuntu/+source/lxc-android-config"
SRC_URI="https://launchpad.net/ubuntu/+archive/primary/+files/${PN}_${PV}.tar.gz"

# unknown license
LICENSE=""
SLOT="0"
KEYWORDS="~arm"
IUSE=""

RDEPEND="${DEPEND}"
DEPEND=""

S="${WORKDIR}/${PN}-${PV}"

src_unpack() {
	unpack ${A}
	cd "${S}"
}

src_install() {
    ls -lh
    local LXC_ANDROID_CONFIG="usr/lib/lxc-android-config/"
    local LXC_ANDROID="var/lib/lxc/android"

    # Install lxc android config files
    pushd $LXC_ANDROID_CONFIG

    exeinto "/$LXC_ANDROID_CONFIG"
    doexe update-fstab && rm update-fstab

    insinto "/$LXC_ANDROID_CONFIG"
    for i in *; do
	newins $i $i
    done
    popd # $LXC_ANDROID_CONFIG

    # Install lxc android template rootfs
    # NOTE: We use different path then ubuntu
    pushd $LXC_ANDROID
    insinto "/etc/lxc/android"
    newins config config

    exeinto "/etc/lxc/android"
    doexe pre-start.sh && rm pre-start.sh

    pushd pre-start.d
    exeinto "/etc/lxc/android.pre-start.d"
    for i in *; do
	doexe $i
    done
    popd # pre-start.d
    popd # $LXC_ANDROID

    # create dir
    dodir "/etc/lxc/android/overrides"
    dodir "/etc/lxc/android/rootfs"

    # create symlink
    dosym "/etc/lxc/android" "/var/lib/lxc/android"

}
