
git status

# zobraz stav (sledované / ignorované súbory)
git status
# stiahni zmeny z GitHubu
git pull
# pridaj zmeny a commitni
git add .
git commit -m "Popis zmeny"
# odošli na GitHub
git push
# Overenie ignorovaných súborov
git check-ignore -v cesta/k_suboru




## Poznámky
rm -rf .git
git init
git add .
git commit -m "Initial commit"
git branch -M main 
git remote add origin git@github.com:saupsaup/Dev.git
git push -u origin main --force
git status

# Zobraziť všetky ignorované súbory (globálne)
git status --ignored

# Overiť, či konkrétny súbor je ignorovaný
git check-ignore -v <cesta/k/suboru>
git check-ignore -v Dev_V200/200/_Nh_DEV.st


# git rm -r --cached *.PNG *.png || true      # 2. vyhoď všetky PNG z indexu (repozitár), ale nechaj ich na disku
# git rm -r --cached Dev_V200/**/*.PNG Dev_V200/**/*.png || true
#  # git odstrani uplne vsetko co je aktualne sledovane v aktualnom priecinku aj -r = 
git rm -r --cached .       
# pridaj zmeny a commitni
git add .
git commit -m "Reset repo" 
# odošli na GitHub
git push           