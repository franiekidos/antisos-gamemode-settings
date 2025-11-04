# Maintainer: Your Name <youremail@domain.com>
pkgname=antisos-gamemode-settings
pkgver=1.0.0
pkgrel=1
pkgdesc="Scripts and a GUI configurator for a SteamOS-like gamemode session using Gamescope."
arch=('any')
url=""
license=('MIT')
depends=(
    'gamescope'
    'gtk4'
    'libadwaita'
    'python-gobject'
    'polkit'
)
optdepends=(
    'steam: For running Steam in Deck UI mode'
    'es-de-launcher: For running EmulationStation-DE'
    'mangohud: For the MangoHud overlay option'
    'nvidia-utils: For applying NVIDIA-specific workarounds'
)
source=("git+https://github.com/franiekidos/antisos-gamemode-settings.git")
sha256sums=('SKIP')

package() {
    # Install the main scripts to /usr/bin
    install -Dm755 "$srcdir/antisos-gamemode-settings/gamemode-run" "$pkgdir/usr/bin/gamemode-run"
    install -Dm755 "$srcdir/antisos-gamemode-settings/antisos-gamemode-settings.py" "$pkgdir/usr/bin/antisos-gamemode-settings.py"
    install -Dm755 "$srcdir/antisos-gamemode-settings/steamdeck-ui" "$pkgdir/usr/bin/steamdeck-ui"
    install -Dm755 "$srcdir/antisos-gamemode-settings/es-de-run" "$pkgdir/usr/bin/es-de-run"

    # Install the SteamOS placeholder scripts
    install -Dm755 "$srcdir/antisos-gamemode-settings/steamos-select-branch." "$pkgdir/usr/bin/steamos-select-branch"
    
    # Create the helper directory and install the dock updater script
    install -d "$pkgdir/usr/bin/steamos-polkit-helpers"
    install -Dm755 "$srcdir/antisos-gamemode-settings/jupiter-dock-updater" "$pkgdir/usr/bin/steamos-polkit-helpers/jupiter-dock-updater"

    # Install the desktop file for the application menu
    install -Dm644 "$srcdir/antisos-gamemode-settings/antisos-gamemode-settings.desktop" "$pkgdir/usr/share/applications/antisos-gamemode-settings.desktop"

    # Install license file
    install -Dm644 /dev/null "$pkgdir/usr/share/licenses/$pkgname/LICENSE"
    # You should create a LICENSE file with the text of the MIT license.
    # For now, this creates an empty one.
}