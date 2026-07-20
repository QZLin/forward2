param($TargetDir)
Push-Location $TargetDir
foreach ($file in Get-ChildItem -Filter *.go ) {
    $content = Get-Content $file
    $content = $content `
        -replace "^package forward$", "package forward2" `
        -replace '"forward"', '"forward2"'
    Set-Content -Path $file -Value $content
}
Pop-Location