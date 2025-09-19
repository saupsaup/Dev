# Projekt Dev

Tento repozitár obsahuje zdrojové kódy a projekty v priečinku `Dev_V200`.

## Štruktúra projektu

- `Dev_V200/200/`  
  Hlavný projekt, ktorý je aktuálne sledovaný Gitom.  
- Ostatné podpriečinky v `Dev_V200/` sú ignorované podľa `.gitignore`.

---

## Ako pracovať s repozitárom

### Základné príkazy Git

```bash
# zobraz stav (sledované / ignorované súbory)
git status

# stiahni zmeny z GitHubu
git pull

# pridaj zmeny a commitni
git add .
git commit -m "Popis zmeny"

# odošli na GitHub
git push
```

### Overenie ignorovaných súborov

```bash
git check-ignore -v cesta/k_suboru
```

---

## Ako pridať nový projekt (napr. `201`) do sledovania

```bash
# 1. Otvor .gitignore a pridaj riadok:
# !Dev_V200/201/

# 2. Pridaj priečinok do gitu a commitni
git add .gitignore Dev_V200/201
git commit -m "Start tracking Dev_V200/201"
git push
```
```bash
# 1. Pridaj RADME.md
git add README.md
git commit -m "Add README with usage instructions"
git push
```

## Ako vyradiť projekt (napr. `201`) zo sledovania

```bash
# 1. Odstráň riadok !Dev_V200/201/ zo súboru .gitignore

# 2. Vyrad priečinok zo sledovania, ale súbory si nechaj lokálne
git rm -r --cached Dev_V200/200_Lib
git add .gitignore
git commit -m "Stop tracking Dev_V200/200_Lib"
git push
```

---

```bash
# znamená prepíš obsah súboru .gitignore tým, čo je medzi EOF a EOF.
cat > .gitignore <<'EOF'
Dev/*             # ignoruj všetko v Dev/
!Dev/Dev_V200/    # povol priečinok Dev_V200
!Dev/Dev_V200/200/  # povol iba priečinok 200
EOF


# vyradit subory zo sledovania, kred u su v indexe

 1. pridaj ignorovanie PNG do .gitignore (ak tam ešte nie je)
echo -e "\n*.PNG\n*.png" >> .gitignore
\n = nový riadok,
*.PNG = pattern pre všetky súbory končiace na .PNG,
ďalší \n → nový riadok,
*.png = pattern pre malé písmená.
(prázdny riadok)
*.PNG
*.png


# git rm -r --cached *.PNG *.png || true      # 2. vyhoď všetky PNG z indexu (repozitár), ale nechaj ich na disku
# git rm -r --cached Dev_V200/**/*.PNG Dev_V200/**/*.png || true

git rm -r --cached .        # git odstrani uplne vsetko co je aktualne sledovane v aktualnom priecinku aj -r = podpriecinky - musi prist add git add Dev_V200/200
git add .gitignore          # zmeny (.gitignore + úprava indexu)
git add .gitattributes 
git add README.md      
git add Dev_V200/200        # pridat spat sledovanie
git commit -m "Remove PNG files from repo and ignore them"  ## 4. commitni zmenu
git push                    # # 5. pushni na GitHub




## Poznámky

- `.gitignore` je nastavený tak, aby Git sledoval iba priečinky, ktoré sú explicitne povolené (`!Dev_V200/XXX/`).  
- Všetky ostatné podpriečinky v `Dev_V200` sú ignorované.  
- Tento prístup ti umožňuje flexibilne pridávať alebo odoberať projekty zo sledovania.  
- Pre kontrolu môžeš použiť pomocný skript:
  ```bash
  ./git-check.sh
  ```




Áno 👍, dá sa urobiť úplný „reset do čista“ — ako keby si repozitár práve založil a nemal žiadnu históriu commitov.

Variant A – zachováš repozitár na GitHube, ale vymažeš históriu

Lokálne si vytvoríš nový orphan-branch (bez histórie):

git checkout --orphan fresh-start
git rm -rf .
echo "# New clean start" > README.md
git add README.md .gitignore
git commit -m "Fresh start"


Prepíšeš vzdialený main:

git branch -M main
git push -u origin main --force

👉 Na GitHube ostane len tento nový commit, stará história zmizne.

Variant B – zmažeš celý repozitár na GitHube

Na GitHube → repo Settings → Danger Zone → Delete this repository.

Lokálne:

rm -rf .git
git init
git remote add origin git@github.com:saupsaup/Dev.git
git add .
git commit -m "Initial commit"
git push -u origin main


👉 Toto je najčistejšie — všetko sa začne od nuly.

🔑 Rozdiel:

A = necháš si repo (link, issues, access), ale históriu komplet vynuluješ.

B = totálne od nuly aj na GitHube, akoby repo nikdy neexistovalo.