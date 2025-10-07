#!/bin/zsh
echo "=== SLEDOVANÉ SÚBORY (git ls-files) ==="
git    v

echo
echo "=== IGNOROVANÉ SÚBORY (git status --ignored) ==="
git status --ignored -s

echo
echo "=== STAV REPOZITÁRA (git status) ==="
git status

