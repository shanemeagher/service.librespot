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

from lib import alsaaudio as alsa
import xbmcaddon
import xbmcgui

if __name__ == "__main__":

  addon   = xbmcaddon.Addon("service.librespot")
  dialog  = xbmcgui.Dialog()
  strings = addon.getLocalizedString

  while True:
    pcms = alsa.pcms()[1:]
    if len(pcms) == 0:
      dialog.ok(strings(30211), strings(30212)) 
      break
    pcmx = dialog.select(strings(30113), pcms)
    if pcmx == -1:
      break
    pcm = pcms[pcmx]
    pair = pcm.split(":CARD=")
    device = pair[0]
    card = pair[1].split(",")[0]
    cardx = alsa.cards().index(card)
    mixers = [mixer for mixer in alsa.mixers(cardindex=cardx, device=device)
        if 'Playback Volume' in alsa.Mixer(control=mixer, cardindex=cardx).volumecap()]
    if len(mixers) == 0:
      mixer = ""
    else:
      mixerx = dialog.select(strings(30114), mixers)
      if mixerx == -1:
        continue
      mixer = mixers[mixerx]
    addon.setSetting("ls_m", mixer)
    addon.setSetting("ls_o", pcm)
    break
