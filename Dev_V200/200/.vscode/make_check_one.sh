#!/bin/sh
set -eu

# relatívna cesta k .st (voči rootu projektu)
rel="${1:-}"
if [ -z "$rel" ]; then
  echo "ERR: missing relative file path" >&2
  exit 1
fi
case "$rel" in ./*) rel="${rel#./}";; esac

ROOT="$(pwd)"
MAK_MAIN="${ROOT}/V200.mak"      # ak sa volá inak, uprav tu
PLC_MAIN="${MAK_MAIN%*.mak}.plc"
OUT_DIR="${ROOT}/.vscode"
OUT_MAK="${OUT_DIR}/_check_one.mak"
OUT_PLC="${OUT_DIR}/_check_one.plc"

[ -f "$MAK_MAIN" ] || { echo "ERR: not found: $MAK_MAIN" >&2; exit 1; }
mkdir -p "$OUT_DIR"

# skopíruj PLC (ak existuje)
if [ -f "$PLC_MAIN" ]; then
  cp -f "$PLC_MAIN" "$OUT_PLC"
fi

trim() { echo "$1" | sed 's/^[[:space:]]*//; s/[[:space:]]*$//'; }
is_abs_or_unc() {
  case "$1" in [A-Za-z]:[\\/]*|\\\\*) return 0 ;; *) return 1 ;; esac
}

libname=""
USEOPTS_FILE="${OUT_DIR}/_useopts.tmp"
USELIBS_FILE="${OUT_DIR}/_uselibs.tmp"
USEFILES_FILE="${OUT_DIR}/_usefiles.tmp"
: > "$USEOPTS_FILE"; : > "$USELIBS_FILE"; : > "$USEFILES_FILE"

inlibs=0
while IFS= read -r line || [ -n "$line" ]; do
  l="$(trim "$line")"
  case "$l" in
    \#libname\ *) [ -z "$libname" ] && libname="$l" ;;
    \#useoption\ *) echo "$l" >> "$USEOPTS_FILE" ;;
    \#uselib\ *\"*\"*)
      [ $inlibs -eq 0 ] && inlibs=1
      p=$(echo "$l" | sed -n 's/^[[:space:]]*#uselib[[:space:]]*"\(.*\)".*/\1/p')
      if is_abs_or_unc "$p"; then echo "#uselib \"$p\"" >> "$USELIBS_FILE"
      else echo "#uselib \"..\\$p\"" >> "$USELIBS_FILE"; fi
      ;;
    \#endlibs)
      if [ $inlibs -eq 1 ]; then echo "#endlibs" >> "$USELIBS_FILE"; inlibs=0; fi
      ;;
    \#usefile\ *\"*\"*)
      f=$(echo "$l" | sed -n 's/^[[:space:]]*#usefile[[:space:]]*"\(.*\)".*/\1/p')
      [ -z "$f" ] || {
        if is_abs_or_unc "$f"; then echo "#usefile \"$f\"" >> "$USEFILES_FILE"
        else echo "#usefile \"..\\$f\"" >> "$USEFILES_FILE"; fi
      }
      ;;
    *) [ $inlibs -eq 1 ] && echo "$line" >> "$USELIBS_FILE" ;;
  esac
done < "$MAK_MAIN"

REL_WIN="..\\$(echo "$rel" | sed 's:/:\\:g')"
# nepridávaj duplikát
grep -qi "^#usefile \".*$(printf "%s" "$REL_WIN" | sed 's/[\\^$.*/[]/\\&/g')\"$" "$USEFILES_FILE" || echo "#usefile \"$REL_WIN\"" >> "$USEFILES_FILE"

{
  echo "#program 999 , CheckOne"
  [ -n "$libname" ] && echo "$libname"
  cat "$USEOPTS_FILE"
  [ -s "$USELIBS_FILE" ] && cat "$USELIBS_FILE"
  cat "$USEFILES_FILE"
} > "$OUT_MAK"

rm -f "$USEOPTS_FILE" "$USELIBS_FILE" "$USEFILES_FILE"

echo "[ok] .vscode/_check_one.mak prepared"
[ -f "$OUT_PLC" ] && echo "     + _check_one.plc copied from $(basename "$PLC_MAIN")" || echo "     ! NOTE: $(basename "$PLC_MAIN") not found — run full build once"
