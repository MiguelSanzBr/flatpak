# Miguel Sanz Flatpak repository

Signed Flatpak repository of three open-source Linux configurators, served by GitHub Pages at
<https://miguelsanzbr.github.io/flatpak/>:

| App | For | App ID | Source |
|---|---|---|---|
| Ultimate Pad Config | 8BitDo Ultimate 2 Wireless | `io.github.miguelsanzbr._8bitdo-ultimate2-linux` | [8bitdo-ultimate2-linux](https://github.com/MiguelSanzBr/8bitdo-ultimate2-linux) |
| Cyclone Pad Config | GameSir Cyclone 2 | `io.github.miguelsanzbr.gamesir-cyclone2-linux` | [gamesir-cyclone2-linux](https://github.com/MiguelSanzBr/gamesir-cyclone2-linux) |
| Shark Mouse Config | ATTACK SHARK X11 | `io.github.miguelsanzbr.attackshark-x11-linux` | [attackshark-x11-linux](https://github.com/MiguelSanzBr/attackshark-x11-linux) |

## Install

```bash
flatpak remote-add --user --if-not-exists miguelsanz https://miguelsanzbr.github.io/flatpak/miguelsanz.flatpakrepo
flatpak install --user miguelsanz io.github.miguelsanzbr.gamesir-cyclone2-linux
```

The apps need the Freedesktop runtime from Flathub, and the device's udev rule installed once on the host (see each
app's README). This repository is not part of Flathub.

## Publishing a new version

1. Point the app's manifest in `apps/` at the new tag and its commit.
2. Run `./publish.sh`: it rebuilds every app into `repo/`, signs the commits and refreshes the summary, the AppStream
   data and the static deltas. The signing key stays outside this repository (`~/.local/share/flatpak-signing/gnupg`
   by default, or `$FLATPAK_GPG_HOME`).
3. Commit and push; GitHub Pages serves the new `repo/`.

Signing key fingerprint: `49A5 8198 384A D943 1D76 C43F 52FE DA95 07A6 33EC`.

The manifests and scripts here are MIT licensed. Not affiliated with 8BitDo, GameSir or ATTACK SHARK.
