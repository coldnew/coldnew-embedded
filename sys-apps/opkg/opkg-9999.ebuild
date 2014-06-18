# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="4"

inherit eutils git-2 autotools

DESCRIPTION="Opkg is a lightweight package management system based upon ipkg"
HOMEPAGE="http://code.google.com/p/opkg/"
EGIT_REPO_URI="git://git.yoctoproject.org/opkg"
#EGIT_COMMIT=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~arm"
IUSE="static static-libs curl openssl gpg "

DEPEND="
	static? (
		curl? ( net-misc/curl[static-libs] )
		openssl? ( dev-libs/openssl[static-libs] )
		gpg? ( app-crypt/gnupg[static-libs] )
		app-arch/libarchive[static-libs]
		net-dns/c-ares[static-libs]
	)
	!static? (
		curl? ( net-misc/curl )
		openssl? ( dev-libs/openssl )
		gpg? ( app-crypt/gnupg )
		app-arch/libarchive
		net-dns/c-ares
	)
	"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

src_prepare() {
    eautoreconf
}

src_configure() {
    econf  \
	$(use_enable static) \
	$(use_enable curl) \
	$(use_enable openssl) \
	$(use_enable gpg) \
	$(use static-libs && echo "--with-static-libopkg")
}

src_compile() {
        emake CC="$(tc-getCC)" || die "emake failed"
}

src_install() {
	default

	# create /var/run dir for opkg generate /var/run/opkg.lock file
	dodir /var/run

	# create /etc/opkg dir for store opkg.cong
	dodir /etc/opkg

	# remove .la files since we are building only shared libraries
	prune_libtool_files
}

pkg_postinst() {
	elog "Consider installing sys-apps/fakeroot for use with the opkg-build command,"
	elog "that makes it possible to build packages as a normal user."


}
