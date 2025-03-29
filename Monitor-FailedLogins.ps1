function Monitor-FailedLogins {
    Write-Host "`n🚨 Surveillance avancée des tentatives de connexion échouées..." -ForegroundColor Cyan

    # Demander à l'utilisateur une plage de jours ou utiliser la valeur par défaut (7 jours)
    $days = Read-Host "🔢 Combien de jours souhaitez-vous analyser ? (Appuyez sur Entrée pour utiliser 7 jours par défaut)"
    
    if ($days -match '^\d+$') {
        $days = [int]$days
        Write-Host "📅 Analyse des tentatives échouées sur les $days derniers jours..." -ForegroundColor Green
    } else {
        $days = 7
        Write-Host "⚙️  Mode automatique : Analyse des 10 dernières tentatives sur les 7 derniers jours." -ForegroundColor Yellow
    }

    # Définir la période d'analyse
    $startTime = (Get-Date).AddDays(-$days)
    $failedEvents = Get-WinEvent -FilterHashtable @{LogName="Security"; Id=4625; StartTime=$startTime} -ErrorAction SilentlyContinue

    if ($failedEvents) {
        $failures = $failedEvents | ForEach-Object {
            $msg = $_.Message
            $ip = if ($msg -match "Source Network Address:\s+([\d\.]+)") { $matches[1] } else { "Inconnu" }
            $user = if ($msg -match "Account Name:\s+(\S+)") { $matches[1] } else { "Inconnu" }
            $reason = if ($msg -match "Failure Reason:\s+(.+)") { $matches[1] } else { "Non spécifié" }

            [PSCustomObject]@{
                Date        = $_.TimeCreated
                Utilisateur = $user
                AdresseIP   = $ip
                Raison      = $reason
            }
        }

        # Résumé des tentatives de connexion par IP
        Write-Host "`n📊 Résumé des tentatives de connexion par adresse IP :" -ForegroundColor Green
        $failures | Group-Object AdresseIP | Sort-Object Count -Descending | Select-Object Name, Count | Format-Table -AutoSize

        # Détection d'IP suspectes (plus de 5 tentatives dans la période sélectionnée)
        $ipSuspicious = $failures | Group-Object AdresseIP | Where-Object { $_.Count -gt 5 }
        if ($ipSuspicious) {
            Write-Host "`n⚠️  Activité suspecte détectée !" -ForegroundColor Red
            $ipSuspicious | Format-Table Name, Count -AutoSize
        }

        # Affichage des détails des 10 dernières tentatives échouées
        Write-Host "`n🔍 Détails des 10 dernières tentatives échouées :" -ForegroundColor Green
        $failures | Sort-Object Date -Descending | Select-Object -First 10 | Format-Table -AutoSize
    } else {
        Write-Host "✅ Aucun événement d'échec trouvé sur les $days derniers jours." -ForegroundColor Yellow
    }
}
