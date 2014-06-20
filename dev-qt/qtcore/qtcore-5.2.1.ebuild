# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

QT5_MODULE="qtbase"

inherit qt5-build

DESCRIPTION="The Qt toolkit is a comprehensive C++ application development framework"

if [[ ${QT5_BUILD_TYPE} == live ]]; then
    KEYWORDS=""
else
    KEYWORDS="arm"
fi

IUSE="+glib icu opengl gles2"

DEPEND="
        >=dev-libs/libpcre-8.30[pcre16]
        sys-libs/zlib
        virtual/libiconv
        glib? ( dev-libs/glib:2 )
        icu? ( dev-libs/icu:= )
"
RDEPEND="${DEPEND}"

QT5_TARGET_SUBDIRS=(
    src/tools/bootstrap
    src/tools/moc
    src/tools/rcc
    src/corelib
)
QCONFIG_DEFINE=( QT_ZLIB )

pkg_setup() {
    QCONFIG_REMOVE=(
        $(usev !glib)
        $(usev !icu)
    )

    # NOTE: fix for arm gles problem, which lead to build
    # qtdeclarative failed.
    QCONFIG_ADD=(
        $(use gles2 && echo opengles2)
        $(usev opengl)
    )
    QCONFIG_DEFINE=(
        $(use gles2     && echo QT_OPENGL_ES QT_OPENGL_ES_2)
        $(use opengl    || echo QT_NO_OPENGL)
    )

    qt5-build_pkg_setup
}

src_configure() {
    local myconf=(
        $(qt_use glib)
        -iconv
        $(qt_use icu)
    )
    qt5-build_src_configure
}
