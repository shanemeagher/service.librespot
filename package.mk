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
PKG_VERSION="6a0657fec6f887fda8276e5c70317dec887b90dd"
PKG_REV="100-alpha2"
PKG_ARCH="x86_64 arm"
PKG_ADDON_PROJECTS="Generic RPi RPi2"
PKG_LICENSE="prop."
PKG_SITE="https://github.com/plietar/librespot/"
PKG_URL="https://github.com/plietar/librespot/archive/$PKG_VERSION.zip"
#PKG_SOURCE_DIR="librespot"
#PKG_DEPENDS_TARGET="toolchain libvorbis libogg libportaudio2 libjack"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="service"
PKG_SHORTDESC="Librespot: use Spotify Connect through LibreELEC"
PKG_LONGDESC="Librespot (2017-02-22 - $PKG_VERSION) plays Spotify through LibreELEC using the opensource librespot library and, using a Spotify app as a remote."
PKG_AUTORECONF="no"

PKG_IS_ADDON="yes"
PKG_ADDON_NAME="Librespot"
PKG_ADDON_TYPE="xbmc.service"
PKG_MAINTAINER="Shane Meagher (shanemeagher)"

#post_unpack() {
#  mkdir -p $PKG_BUILD
#  mv $BUILD/$PKG_SOURCE_DIR/* $PKG_BUILD/
#  rm -r $BUILD/$PKG_NAME-$PKG_VERSION*
#}

make_target() {
  : # nop
}

makeinstall_target() {
  : # nop
}

addon() {

  # Create subfolders
  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/bin/

  # Copy architecture specific librespot executable to bin/ folder
  if [ "$PROJECT" = "Generic" ]; then
    if [ "$TARGET_ARCH" = "x86_64" ]; then
      if [ "$DEBUG" = "yes" ]; then
        cp $ROOT/packages/addons/service/librespot/binaries/x86_64/debug/* $ADDON_BUILD/$PKG_ADDON_ID/bin/
      else
        cp $ROOT/packages/addons/service/librespot/binaries/x86_64/release/* $ADDON_BUILD/$PKG_ADDON_ID/bin/
      fi
    fi
  elif [ "$PROJECT" = "RPi" ]; then
    if [ "$TARGET_ARCH" = "arm" ]; then
      if [ "$DEBUG" = "yes" ]; then
        cp $ROOT/packages/addons/service/librespot/binaries/armel/debug/* $ADDON_BUILD/$PKG_ADDON_ID/bin/
      else
        cp $ROOT/packages/addons/service/librespot/binaries/armel/release/* $ADDON_BUILD/$PKG_ADDON_ID/bin/
      fi
    fi
  elif [ "$PROJECT" = "RPi2" ]; then
    if [ "$TARGET_ARCH" = "arm": ]; then
      if [ "$DEBUG" = "yes" ]; then
        cp $ROOT/packages/addons/service/librespot/binaries/armhf/debug/* $ADDON_BUILD/$PKG_ADDON_ID/bin/
      else
        cp $ROOT/packages/addons/service/librespot/binaries/armhf/release/* $ADDON_BUILD/$PKG_ADDON_ID/bin/
      fi
    fi
  fi

#  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/lib

  # Copy librespot to bin folder
  # Not used until determine how to make librespot using cargo
  #cp -P $(get_build_dir $PKG_NAME)/target/release/$PKG_NAME $ADDON_BUILD/$PKG_ADDON_ID/bin

  # Copy libportaudio2 library and create symlink
#  cp -L $(get_build_dir libportaudio2)/.install_pkg/usr/lib/* $ADDON_BUILD/$PKG_ADDON_ID/lib/
#  ln -s $ADDON_BUILD/$PKG_ADDON_ID/lib/libportaudio.so $ADDON_BUILD/$PKG_ADDON_ID/lib/libportaudio.so.2

  # Copy libdb-5.3 library
#  cp -P $(get_build_dir libdb)/.install_pkg/usr/local/BerkeleyDB.5.3/lib/* $ADDON_BUILD/$PKG_ADDON_ID/lib/

  # Copy libjack library
#  cp -P $(get_build_dir libjack)/.install_pkg/usr/local/lib64/libjack.so* $ADDON_BUILD/$PKG_ADDON_ID/lib/

  # Copy libvorbis and libvorbisfile libraries
#  cp -P $(get_build_dir libvorbis)/.install_pkg/usr/lib/libvorbis.so* $ADDON_BUILD/$PKG_ADDON_ID/lib/
#  cp -P $(get_build_dir libvorbis)/.install_pkg/usr/lib/libvorbisfile.so* $ADDON_BUILD/$PKG_ADDON_ID/lib/

  # Copy libogg library
#  cp -P $(get_build_dir libogg)/.install_pkg/usr/lib/libogg.so* $ADDON_BUILD/$PKG_ADDON_ID/lib/

  # Copy libgcc_s library and create symlink
#  cp -L $(get_build_dir libgcc)/$TARGET_NAME/libgcc/libgcc_s.so.1 $ADDON_BUILD/$PKG_ADDON_ID/lib/
#  ln -s $ADDON_BUILD/$PKG_ADDON_ID/lib/libgcc_s.so.1 $ADDON_BUILD/$PKG_ADDON_ID/lib/libgcc_

  cp -PR $PKG_BUILD/* $ADDON_BUILD/$PKG_ADDON_ID/

  rm -rf $ADDON_BUILD/$PKG_ADDON_ID/cache \
         $ADDON_BUILD/$PKG_ADDON_ID/contrib \
         $ADDON_BUILD/$PKG_ADDON_ID/docs \
         $ADDON_BUILD/$PKG_ADDON_ID/protocol \
         $ADDON_BUILD/$PKG_ADDON_ID/src

  rm -f $ADDON_BUILD/$PKG_ADDON_ID/build.rs \
        $ADDON_BUILD/$PKG_ADDON_ID/Cargo.*

}
