function Check-Firewall {
    Write-Host "`n🛑 Analyse avancée de la configuration du pare-feu..." -ForegroundColor Cyan
    
    # Affichage des profils du pare-feu
    Write-Host "`n>> Profils du pare-feu :" -ForegroundColor Green
    Get-NetFirewallProfile | Select-Object Name, Enabled, DefaultInboundAction, DefaultOutboundAction | Format-Table -AutoSize

    # Liste des règles entrantes activées avec action "Allow"
    Write-Host "`n>> Règles entrantes autorisant le trafic (ALLOW) :" -ForegroundColor Green
    $inboundAllow = Get-NetFirewallRule -Direction Inbound -Action Allow -Enabled True |
                    Get-NetFirewallPortFilter |
                    Select-Object @{Name="Nom";Expression={$_.InstanceID}}, Protocol, LocalPort
    if ($inboundAllow) {
        $inboundAllow | Format-Table -AutoSize
    } else {
        Write-Host "Aucune règle entrante autorisante détectée." -ForegroundColor Yellow
    }
    
    # Vérification de règles avec des adresses IP non restreintes
    Write-Host "`n>> Règles avec portée d'adresse IP étendue :" -ForegroundColor Green
    $allRules = Get-NetFirewallRule -Enabled True -Direction Inbound | ForEach-Object {
        $rule = $_
        $filter = Get-NetFirewallAddressFilter -AssociatedNetFirewallRule $rule
        [PSCustomObject]@{
            Nom         = $rule.DisplayName
            RemoteIP    = $filter.RemoteAddress
            Action      = $rule.Action
        }
    }
    $allRules | Where-Object { $_.RemoteIP -eq "Any" -or $_.RemoteIP -match "0.0.0.0/0" } | Format-Table -AutoSize
}
