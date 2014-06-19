# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/eix/eix-0.30.2.ebuild,v 1.1 2014/05/07 19:34:53 axs Exp $

EAPI=5

inherit bash-completion-r1 eutils l10n

DESCRIPTION="Wrapper for eix to make crossdev build more easy."

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="app-portage/eix
	sys-devel/crossdev"
DEPEND="${RDEPEND}"

S="${WORKDIR}"

src_install() {
	dobin "${FILESDIR}"/eix-wrapper
	dobin "${FILESDIR}"/eix-update-wrapper
}
