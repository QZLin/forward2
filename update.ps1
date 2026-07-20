if (Test-Path _DEBUG) {
    git clone https://github.com/qzlin/forward
    git clone https://github.com/qzlin/forward2
}

Push-Location forward2
#git reset HEAD~1 --hard
git pull ../forward --rebase -X theirs
../rename_all.ps1 .
go mod init github.com/qzlin/forward2
go mod tidy
git add .
git status
git commit -a -m 'rename'
# push will handled by actions
# git push --force
Pop-Location
