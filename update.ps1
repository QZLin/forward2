if (Test-Path _DEBUG) {
    git clone https://github.com/qzlin/forward
    git clone https://github.com/qzlin/forward2
}

Push-Location forward2
git reset HEAD~1 --hard
git pull ../forward
../rename_all.ps1 .
go mod init github.com/qzlin/forward2
go mod tidy
git add go.mod go.sum
git add
git commit -a -m 'rename'
# git push --force
Pop-Location
