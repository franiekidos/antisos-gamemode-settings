# Maintainer: Your Name <youremail@domain.com>
pkgname=antisos-gamemode-settings-git
_pkgname=antisos-gamemode-settings
pkgver() {
  cd "$_pkgname"
  printf "r%s.%s" "$(git rev-list --count HEAD)" "$(git rev-parse --short HEAD)"
}
pkgdesc="Scripts and a GUI configurator for a SteamOS-like gamemode session using Gamescope."
arch=('any')
url=""
license=('MIT')
depends=(
    'gamescope'
    'gtk4'
    'libadwaita'
    'polkit'
)
makedepends=(
    'git'
    'pyinstaller'
    'python-gobject'
)
optdepends=(
    'steam: For running Steam in Deck UI mode'
    'es-de-launcher: For running EmulationStation-DE'
    'mangohud: For the MangoHud overlay option'
    'nvidia-utils: For applying NVIDIA-specific workarounds'
)
conflicts=("antisos-gamemode-settings")
provides=("antisos-gamemode-settings")
source=("git+https://github.com/franiekidos/antisos-gamemode-settings.git")
sha256sums=('SKIP')

build() {
    cd "$srcdir/$_pkgname"
    # Compile the Python script into a single executable without a console window
    pyinstaller --onefile --windowed --name antisos-gamemode-settings antisos-gamemode-settings
}

package() {
    cd "$srcdir/$_pkgname"

    # Install the main scripts to /usr/bin
    install -Dm755 "gamemode-run.sh" "$pkgdir/usr/bin/gamemode-run.sh"
    install -Dm755 "steamdeck-ui" "$pkgdir/usr/bin/steamdeck-ui"
    install -Dm755 "es-de-run" "$pkgdir/usr/bin/es-de-run"

    # Install the compiled application from the dist folder created by PyInstaller
    install -Dm755 "dist/antisos-gamemode-settings" "$pkgdir/usr/bin/antisos-gamemode-settings"

    # Install the SteamOS placeholder scripts
    install -Dm755 "steamos-select-branch.sh" "$pkgdir/usr/bin/steamos-select-branch"
    
    # Create the helper directory and install the dock updater script
    install -d "$pkgdir/usr/bin/steamos-polkit-helpers"
    install -Dm755 "jupiter-dock-updater.sh" "$pkgdir/usr/bin/steamos-polkit-helpers/jupiter-dock-updater"

    # Install the desktop and session files
    install -Dm644 "antisos-gamemode-settings.desktop" "$pkgdir/usr/share/applications/antisos-gamemode-settings.desktop"
    install -Dm644 "antisos-gamemode.desktop" "$pkgdir/usr/share/wayland-sessions/antisos-gamemode.desktop"
}