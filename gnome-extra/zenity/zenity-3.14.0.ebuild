# Distributed under the terms of the GNU General Public License v2

EAPI="5"
GCONF_DEBUG="yes"

inherit gnome2

DESCRIPTION="Tool to display dialogs from the commandline and shell scripts"
HOMEPAGE="https://wiki.gnome.org/Projects/Zenity"

LICENSE="LGPL-2+"
SLOT="0"
KEYWORDS="*"
IUSE="libnotify test +webkit"

RDEPEND="
	>=dev-libs/glib-2.42.0:2
	x11-libs/gdk-pixbuf:2
	>=x11-libs/gtk+-3.14.0:3
	x11-libs/libX11
	x11-libs/pango
	libnotify? ( >=x11-libs/libnotify-0.7.0:= )
	webkit? ( >=net-libs/webkit-gtk-1.4.0:3 )
"
DEPEND="${RDEPEND}
	>=dev-util/intltool-0.40
	>=sys-devel/gettext-0.14
	virtual/pkgconfig
	test? ( app-text/yelp-tools )
"
# eautoreconf needs:
#	>=gnome-base/gnome-common-2.12

src_configure() {
	DOCS="AUTHORS ChangeLog HACKING NEWS README THANKS TODO"

	gnome2_src_configure \
		$(use_enable libnotify) \
		$(use_enable webkit webkitgtk) \
		PERL=$(type -P false) \
		ITSTOOL=$(type -P true)
}

src_install() {
	gnome2_src_install
	rm "${ED}/usr/bin/gdialog" || die "rm gdialog failed!"
}
