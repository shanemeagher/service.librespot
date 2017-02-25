# service.librespot
*service.librespot* is an LibreELEC service addon based on librespot, 
an open source client library for Spotify. *librespot* enables applications to 
use Spotify's service, without using the official but closed-source 
libspotify.

## Building
*service.librespot* must be built from within the LibreELEC build system.
The contents of the sevice.librespot directory must be copied to 
'/packages/addons/service/librespot'.

Currently, only x86_64 builds are possible.

The librespot library is not compiled directly as of yet. If you know how to 
compile Rust from within LibreELEC feel free to add.
