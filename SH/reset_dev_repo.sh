rm -rf .git
git init
git add .
git commit -m "Initial commit"
git branch -M main 
git remote add origin git@github.com:saupsaup/Dev.git
git push -u origin main --force
git status