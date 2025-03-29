function Check-SecurityUpdates {
    Write-Host "`n🔄 Vérification avancée des mises à jour de sécurité..." -ForegroundColor Cyan

    # Vérification des correctifs déjà installés
    Write-Host "`n>> Liste des Hotfix installés :" -ForegroundColor Green
    $hotfixes = Get-HotFix | Sort-Object InstalledOn | Select-Object Description, HotFixID, InstalledOn
    if ($hotfixes) {
        $hotfixes | Format-Table -AutoSize
    } else {
        Write-Host "Aucun hotfix trouvé." -ForegroundColor Yellow
    }
    
    # Si le module PSWindowsUpdate est présent l'utiliser pour des infos plus détaillées
    if (Get-Module -ListAvailable -Name PSWindowsUpdate) {
        Write-Host "`n>> Recherche des mises à jour critiques avec PSWindowsUpdate..." -ForegroundColor Green
        try {
            Import-Module PSWindowsUpdate -ErrorAction Stop
            $updates = Get-WindowsUpdate -MicrosoftUpdate -Criteria "IsInstalled=0 and Type='Software'" -ErrorAction Stop
            if ($updates) {
                $updates | Select-Object Title, KB, Size, MsrcSeverity | Format-Table -AutoSize
            } else {
                Write-Host "Aucune mise à jour critique trouvée."
            }
        } catch {
            Write-Host "Erreur lors de la récupération des mises à jour via PSWindowsUpdate." -ForegroundColor Red
        }
    } else {
        Write-Host "Module PSWindowsUpdate non installé. Pour plus de détails, installez-le." -ForegroundColor Yellow
    }
}
