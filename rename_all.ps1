param( $TargetDir)
Push-Location $TargetDir
foreach ($_ in Get-ChildItem -Filter *.go ) {
    $content = Get-Content $_
    $content = $content `
        -replace "^package forward$", "package forward2" `
        -replace '"forward"', '"forward2"'
    Set-Content -Path $_ -Value $content
}
Pop-Location