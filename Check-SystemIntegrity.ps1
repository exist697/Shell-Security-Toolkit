function Check-SystemIntegrity {
    Write-Host "`n🛠️ Vérification approfondie de l'intégrité du système..." -ForegroundColor Cyan

    Write-Host "`n>> Exécution de SFC (System File Checker)..." -ForegroundColor Green
    $sfcOutput = sfc /scannow
    Write-Host $sfcOutput

    Write-Host "`n>> Vérification de l'état de l'image Windows avec DISM..." -ForegroundColor Green
    $dismOutput = dism /Online /Cleanup-Image /CheckHealth
    Write-Host $dismOutput
}
