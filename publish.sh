#!/bin/bash
# Rebuild every app of apps/ into the signed OSTree repository in repo/ (served by GitHub Pages), then refresh
# its summary, AppStream data and static deltas. Run from anywhere; push the result with git afterwards.
# The signing key lives outside this repository: $FLATPAK_GPG_HOME (default ~/.local/share/flatpak-signing/gnupg).
set -euo pipefail
cd "$(dirname "$0")"
GPG_HOME=${FLATPAK_GPG_HOME:-$HOME/.local/share/flatpak-signing/gnupg}
KEY=$(GNUPGHOME=$GPG_HOME gpg --list-secret-keys --with-colons | awk -F: '/^fpr/{print $10; exit}')
for manifest in apps/*.yml; do
  id=$(basename "$manifest" .yml)
  echo "== $id"
  flatpak run --user org.flatpak.Builder --user --force-clean --install-deps-from=flathub --default-branch=stable \
      --state-dir="$HOME/.cache/flatpak-repo-builder" --repo=repo --gpg-sign="$KEY" --gpg-homedir="$GPG_HOME" \
      "$HOME/.cache/flatpak-repo-builder/build-$id" "$manifest"
done
flatpak build-update-repo --generate-static-deltas --prune --prune-depth=3 --gpg-sign="$KEY" --gpg-homedir="$GPG_HOME" \
    --title="Miguel Sanz" --default-branch=stable repo
