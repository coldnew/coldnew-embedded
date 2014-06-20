# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit autotools base bzr

DESCRIPTION="Hybris is a solution that allows the use of bionic-based HW adaptations in glibc systems."
EBZR_REVISION="53"
EBZR_REPO_URI="lp:ubuntu/libhybris"

HOMEPAGE="https://launchpad.net/libhybris"

LICENSE="LGPL-3"
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
	--enable-arch=${ARCH} \
	--with-android-headers=${SYSROOT}/usr/include/android
}

src_compile() {
	cd "${S}/hybris"
	emake
}

src_install() {
	cd "${S}/hybris"

	emake DESTDIR="${ED}" install

	# TODO:
	# /usr/lib/opengl may can be removed.

	## Integrate with media-libs/mesa ##
	ebegin "Moving GL libs and headers for dynamic switching"
		local x
		local gl_dir="/usr/$(get_libdir)/opengl/${OPENGL_DIR}/"
		dodir ${gl_dir}/{lib,extensions,include/GL}

		for x in "${ED}"/usr/$(get_libdir)/lib{EGL,GL*,OpenVG}.{la,a,so*}; do
			if [ -f ${x} -o -L ${x} ]; then
				mv -f "${x}" "${ED}${gl_dir}"/lib \
					|| die "Failed to move ${x}"
			fi
		done
		for x in "${ED}"/usr/include/GL/{gl.h,glx.h,glext.h,glxext.h}; do
			if [ -f ${x} -o -L ${x} ]; then
				mv -f "${x}" "${ED}${gl_dir}"/include/GL \
					|| die "Failed to move ${x}"
			fi
		done
		for x in "${ED}"/usr/include/{EGL,GLES*,VG,KHR}; do
			if [ -d ${x} ]; then
				mv -f "${x}" "${ED}${gl_dir}"/include \
					|| die "Failed to move ${x}"
			fi
		done
	eend $?
}
