#!/bin/sh
# Factory Director : installation sur Mac. Le jeu n'est pas signé par Apple ; téléchargé par cette commande (et non par
# le navigateur), macOS ne le bloque pas. Télécharge la dernière version, l'installe dans Applications et l'ouvre.
set -e
URL="https://github.com/zarkyxxx/factory-director/releases/latest/download/FactoryDirector-Mac.zip"
TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT
echo "Téléchargement de Factory Director…"
curl -fL --progress-bar "$URL" -o "$TMP/jeu.zip"
/usr/bin/ditto -x -k "$TMP/jeu.zip" "$TMP/jeu"
DEST="/Applications"
[ -w "$DEST" ] || DEST="$HOME/Applications"
mkdir -p "$DEST"
rm -rf "$DEST/FactoryDirector.app"
mv "$TMP/jeu/FactoryDirector.app" "$DEST/"
/usr/bin/xattr -cr "$DEST/FactoryDirector.app" 2>/dev/null || true
echo "Factory Director est installé dans $DEST. Ouverture…"
open "$DEST/FactoryDirector.app"
