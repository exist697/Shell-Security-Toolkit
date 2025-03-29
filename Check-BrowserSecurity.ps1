function Check-BrowserSecurity {
    Write-Host "`n🌍 Vérification avancée de la sécurité du navigateur (Chrome)..." -ForegroundColor Cyan

    # Vérifier la présence d'extensions dans Chrome
    $chromeExtensionsPath = "$env:LOCALAPPDATA\Google\Chrome\User Data\Default\Extensions"
    if (Test-Path $chromeExtensionsPath) {
        Write-Host "`n>> Extensions installées pour Chrome :" -ForegroundColor Green
        Get-ChildItem $chromeExtensionsPath | Select-Object Name, FullName | Format-Table -AutoSize
    } else {
        Write-Host "Dossier des extensions Chrome non trouvé." -ForegroundColor Yellow
    }

    # Vérifier l'activation de la navigation sécurisée via le registre 
    Write-Host "`n>> Vérification de la configuration de sécurité dans le registre..."
    $chromeSafeBrowsing = Get-ItemProperty -Path "HKCU:\Software\Google\Chrome\SafeBrowsing" -ErrorAction SilentlyContinue
    if ($chromeSafeBrowsing) {
        Write-Host "SafeBrowsing est configuré :"
        $chromeSafeBrowsing | Format-Table -AutoSize
    } else {
        Write-Host "Les paramètres SafeBrowsing ne sont pas configurés. Vérifie la configuration de Chrome." -ForegroundColor Yellow
    }
}
