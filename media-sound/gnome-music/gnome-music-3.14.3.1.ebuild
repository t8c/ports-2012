# Distributed under the terms of the GNU General Public License v2

EAPI="5"
GCONF_DEBUG="no"
PYTHON_COMPAT=( python3_3 )

inherit gnome2 python-single-r1

DESCRIPTION="Music management for Gnome"
HOMEPAGE="http://wiki.gnome.org/Apps/Music"

LICENSE="GPL-2+"
SLOT="0"
IUSE="python_single_target_python_3.3"
# Let people emerge this by default, bug #472932

KEYWORDS="*"

COMMON_DEPEND="
	${PYTHON_DEPS}
	>=dev-libs/glib-2.42.0:2
	>=dev-libs/gobject-introspection-1.42.0
	>=media-libs/grilo-0.2.6:0.2[introspection]
	media-libs/libmediaart:1.0
	>=x11-libs/gtk+-3.14:3[introspection]
"
# xdg-user-dirs-update needs to be there to create needed dirs
# https://bugzilla.gnome.org/show_bug.cgi?id=731613
RDEPEND="${COMMON_DEPEND}
	app-misc/tracker[introspection(+)]
	|| (
		app-misc/tracker[gstreamer]
		app-misc/tracker[ffmpeg]
	)
	dev-python/pygobject:3[cairo,${PYTHON_USEDEP}]
	dev-python/dbus-python[${PYTHON_USEDEP}]
	media-libs/gstreamer:1.0[introspection]
	media-libs/gst-plugins-base:1.0[introspection]
	media-plugins/gst-plugins-meta:1.0
	media-plugins/grilo-plugins:0.2[tracker]
	x11-misc/xdg-user-dirs
"
DEPEND="${COMMON_DEPEND}
	>=dev-util/intltool-0.26
	virtual/pkgconfig
"

src_configure() {
	gnome2_src_configure ITSTOOL="$(type -P true)"
}

src_install() {
	gnome2_src_install
	python_fix_shebang "${ED}"
}
