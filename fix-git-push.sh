#!/usr/bin/env bash
set -euo pipefail

echo "== Step 1: prefer HTTP/1.1 (obíde HTTP/2 bugy) =="
git config --global http.version HTTP/1.1 || true

echo "== Step 2: zmaž staré credity z macOS Keychain pre github.com =="
printf "protocol=https\nhost=github.com\n" | git credential-osxkeychain erase || true

echo "== Step 3: prepni remote na SSH (stabilné) =="
git remote set-url origin git@github.com:saupsaup/Dev.git

echo "== Step 4: otestuj SSH prístup (očakávaj hlášku 'Hi <user>!') =="
ssh -T git@github.com || true

echo "== Step 5: pushni main (force) =="
git push -u origin main --force

echo "Hotovo."
