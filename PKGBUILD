# Maintainer: Diego N.S <diegons490@gmail.com>
pkgname=cachy-grub-theme
pkgver=1.0
pkgrel=1
pkgdesc="Tema Cachy para o GRUB2"
arch=('any')
url="https://github.com/diegons490/cachy-grub-theme"
license=('GPL')
depends=('grub')
source=("cachy.tar.gz")
sha256sums=('SKIP')

package() {
    install -d "${pkgdir}/boot/grub/themes/cachy"
    tar -xzf "$srcdir/cachy.tar.gz" -C "${pkgdir}/boot/grub/themes/"
}
