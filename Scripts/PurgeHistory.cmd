rmdir /s /q .git

git init
git add .
git commit -m "Initial Commit"

git remote add origin <git master repo uri>
git push -u --force origin master