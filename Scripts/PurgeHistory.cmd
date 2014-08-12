rmdir /s /q .git

git init
git add .
git commit -m "Initial Commit"

git remote add origin https://github.com/thuriot/thuriot.github.io.git
git push -u --force origin master