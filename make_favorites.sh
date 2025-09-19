#!/usr/bin/env bash
set -euo pipefail

# Použitie:
#   ./make_favorites.sh path/to/200.mak [base_dir]
# base_dir = kam doplniť relatívne cesty (default: priečinok s .mak)

MAK="${1:-200.mak}"
BASE="${2:-}"

if [[ ! -f "$MAK" ]]; then
  echo "Nenájdený súbor: $MAK" >&2
  exit 1
fi

# Ak base_dir nebol zadaný, daj priečinok, kde leží .mak
if [[ -z "${BASE}" ]]; then
  BASE="$(cd "$(dirname "$MAK")" && pwd)"
else
  BASE="$(cd "$BASE" && pwd)"
fi

OUT_DIR="${BASE}/.vscode"
mkdir -p "${OUT_DIR}"

# 1) vytiahni názvy zo #usefile "..."
#   - vezmeme len obsah medzi úvodzovkami
#   - odstránime duplikáty a prázdne riadky
grep -oE '#usefile[[:space:]]*"[^"]+"' "$MAK" \
| sed -E 's/^#usefile[[:space:]]*"([^"]+)".*$/\1/' \
| sed '/^[[:space:]]*$/d' \
| sort -u > "${OUT_DIR}/favorites.txt"

# 2) vytvor JSON pole relatívnych (aj absolútnych) ciest
# relatívna cesta (voči BASE)
REL_JSON="${OUT_DIR}/favorites.json"
ABS_JSON="${OUT_DIR}/favorites.abs.json"

# relatívne (iba názvy, ak súbor leží v BASE)
awk -v base="${BASE}" '{
  # ak riadok už vyzerá ako cesta (obsahuje / alebo \), necháme ho,
  # inak doplníme base/filename
  rel=$0
  print "  \"" rel "\""
}' "${OUT_DIR}/favorites.txt" | paste -sd, - \
| awk 'BEGIN{print "["}{print $0}END{print "]"}' > "${REL_JSON}"

# absolútne cesty (pre prípad, že to chceš importovať s absolútnymi)
awk -v base="${BASE}" '{print base "/" $0}' "${OUT_DIR}/favorites.txt" \
| awk '{print "  \"" $0 "\""}' | paste -sd, - \
| awk 'BEGIN{print "["}{print $0}END{print "]"}' > "${ABS_JSON}"

echo
echo "Hotovo ✅"
echo "• Zoznam:        ${OUT_DIR}/favorites.txt"
echo "• JSON (rel.):   ${REL_JSON}"
echo "• JSON (abs.):   ${ABS_JSON}"
echo
echo "Tipy:"
echo "  1) VS Code → nainštaluj rozšírenie 'Favorites' (od Howard Zuo)."
echo "  2) Favorites panel → Import (ak je k dispozícii) → vyber favorites.json alebo favorites.abs.json."
echo "     Ak import v plugine nie je, otvor favorites.txt a pridávaj položky cez 'Add Active File to Favorites'."
