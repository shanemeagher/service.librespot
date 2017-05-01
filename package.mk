################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
#      Copyright (C) 2016 Team LibreELEC
#
#  LibreELEC is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 2 of the License, or
#  (at your option) any later version.
#
#  LibreELEC is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with LibreELEC.  If not, see <http://www.gnu.org/licenses/>.
################################################################################

PKG_NAME="librespot"
PKG_VERSION="30bdcafb7eb7a6e5909f52d09324ae51944c8477"
PKG_REV="1-alpha4"
PKG_ARCH="x86_64 arm"
PKG_ADDON_PROJECTS="Generic RPi RPi2"
PKG_LICENSE="prop."
PKG_SITE="https://github.com/plietar/librespot/"
PKG_URL="https://github.com/plietar/librespot/archive/$PKG_VERSION.zip"
PKG_DEPENDS_TARGET="toolchain libogg libvorbis"
PKG_SECTION="service"
PKG_SHORTDESC="Librespot: use Spotify Connect through LibreELEC"
PKG_LONGDESC="Librespot (2017-04-29 - $PKG_VERSION) plays Spotify through LibreELEC using the opensource librespot library and, using a Spotify app as a remote."
PKG_AUTORECONF="no"

PKG_IS_ADDON="yes"
PKG_ADDON_NAME="Librespot"
PKG_ADDON_TYPE="xbmc.service"
PKG_MAINTAINER="Shane Meagher (shanemeagher)"

make_target() {
  : # nop
}

makeinstall_target() {
  : # nop
}

addon() {

  # Create subfolders
  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/bin/
  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/lib/

  # Copy librespot to bin folder
  # Not used until determine how to make librespot using cargo from within LibreELEC
  #cp -P $(get_build_dir $PKG_NAME)/target/release/$PKG_NAME $ADDON_BUILD/$PKG_ADDON_ID/bin

  # Copy libogg library
  cp -P $(get_build_dir libogg)/.install_pkg/usr/lib/libogg.so* $ADDON_BUILD/$PKG_ADDON_ID/lib/

  # Copy libvorbis and libvorbisfile libraries
  cp -P $(get_build_dir libvorbis)/.install_pkg/usr/lib/libvorbis.so* $ADDON_BUILD/$PKG_ADDON_ID/lib/
  cp -P $(get_build_dir libvorbis)/.install_pkg/usr/lib/libvorbisfile.so* $ADDON_BUILD/$PKG_ADDON_ID/lib/

  # Copy architecture specific librespot executable to bin/ folder and architecture specific libraries to lib/ folder
  if [ "$PROJECT" = "Generic" ]; then
    if [ "$TARGET_ARCH" = "x86_64" ]; then
      if [ "$DEBUG" = "yes" ]; then
        cp $ROOT/packages/addons/service/librespot/binaries/x86_64/debug/* $ADDON_BUILD/$PKG_ADDON_ID/bin/
      else
        cp $ROOT/packages/addons/service/librespot/binaries/x86_64/release/* $ADDON_BUILD/$PKG_ADDON_ID/bin/
      fi
      cp $ROOT/packages/addons/service/librespot/libraries/x86_64/* $ADDON_BUILD/$PKG_ADDON_ID/lib/
    fi
  elif [ "$PROJECT" = "RPi" ]; then
    if [ "$TARGET_ARCH" = "arm" ]; then
      if [ "$DEBUG" = "yes" ]; then
        cp $ROOT/packages/addons/service/librespot/binaries/armel/debug/* $ADDON_BUILD/$PKG_ADDON_ID/bin/
      else
        cp $ROOT/packages/addons/service/librespot/binaries/armel/release/* $ADDON_BUILD/$PKG_ADDON_ID/bin/
      fi
      cp $ROOT/packages/addons/service/librespot/libraries/armel/* $ADDON_BUILD/$PKG_ADDON_ID/lib/
    fi
  elif [ "$PROJECT" = "RPi2" ]; then
    if [ "$TARGET_ARCH" = "arm" ]; then
      if [ "$DEBUG" = "yes" ]; then
        cp $ROOT/packages/addons/service/librespot/binaries/armhf/debug/* $ADDON_BUILD/$PKG_ADDON_ID/bin/
      else
        cp $ROOT/packages/addons/service/librespot/binaries/armhf/release/* $ADDON_BUILD/$PKG_ADDON_ID/bin/
      fi
      cp $ROOT/packages/addons/service/librespot/libraries/armhf/* $ADDON_BUILD/$PKG_ADDON_ID/lib/
    fi
  fi

  cp -nPR $PKG_BUILD/* $ADDON_BUILD/$PKG_ADDON_ID/

  rm -rf $ADDON_BUILD/$PKG_ADDON_ID/cache \
         $ADDON_BUILD/$PKG_ADDON_ID/contrib \
         $ADDON_BUILD/$PKG_ADDON_ID/docs \
         $ADDON_BUILD/$PKG_ADDON_ID/examples \
         $ADDON_BUILD/$PKG_ADDON_ID/protocol \
         $ADDON_BUILD/$PKG_ADDON_ID/src

  rm -f $ADDON_BUILD/$PKG_ADDON_ID/build.rs \
        $ADDON_BUILD/$PKG_ADDON_ID/Cargo.*

}
