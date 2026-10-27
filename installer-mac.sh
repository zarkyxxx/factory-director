#!/bin/sh
# Factory Director : installation sur Mac. Le jeu n'est pas signé par Apple ; téléchargé par cette commande (et non par
# le navigateur), macOS ne le bloque pas. Télécharge la dernière version, l'installe dans Applications et l'ouvre.
set -e
case "${LC_ALL:-${LANG:-}}" in
  fr*) M1="Téléchargement de Factory Director…"; M2="Factory Director est installé dans"; M3="Ouverture…"
       M4="Si vous aviez aussi téléchargé le zip Mac, vous pouvez le mettre à la corbeille : le jeu est dans Applications." ;;
  de*) M1="Factory Director wird heruntergeladen …"; M2="Factory Director ist installiert in"; M3="Wird geöffnet …"
       M4="Falls Sie auch das Mac-ZIP heruntergeladen haben, können Sie es in den Papierkorb legen: Das Spiel ist unter Programme." ;;
  *)   M1="Downloading Factory Director…"; M2="Factory Director is installed in"; M3="Opening…"
       M4="If you also downloaded the Mac zip, you can move it to the Bin: the game is in Applications." ;;
esac
URL="https://github.com/zarkyxxx/factory-director/releases/latest/download/FactoryDirector-Mac.zip"
TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT
echo "$M1"
curl -fL --progress-bar "$URL" -o "$TMP/jeu.zip"
/usr/bin/ditto -x -k "$TMP/jeu.zip" "$TMP/jeu"
DEST="/Applications"
[ -w "$DEST" ] || DEST="$HOME/Applications"
mkdir -p "$DEST"
rm -rf "$DEST/FactoryDirector.app"
mv "$TMP/jeu/FactoryDirector.app" "$DEST/"
/usr/bin/xattr -cr "$DEST/FactoryDirector.app" 2>/dev/null || true
echo "$M2 $DEST. $M3"
echo "$M4"
open "$DEST/FactoryDirector.app"
