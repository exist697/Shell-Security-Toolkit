Clear-Host  # Nettoie l'écran avant d'afficher le titre

Write-Host -ForegroundColor Red @"
 ███████╗██╗  ██╗██╗███████╗████████╗    ███████╗███████╗ ██████╗██╗   ██╗██████╗ ██╗████████╗██╗   ██╗
 ██╔════╝╚██╗██╔╝██║██╔════╝╚══██╔══╝    ██╔════╝██╔════╝██╔════╝██║   ██║██╔══██╗██║╚══██╔══╝╚██╗ ██╔╝
 █████╗   ╚███╔╝ ██║███████╗   ██║       ███████╗█████╗  ██║     ██║   ██║██████╔╝██║   ██║    ╚████╔╝ 
 ██╔══╝   ██╔██╗ ██║╚════██║   ██║       ╚════██║██╔══╝  ██║     ██║   ██║██╔══██╗██║   ██║     ╚██╔╝  
 ███████╗██╔╝ ██╗██║███████║   ██║       ███████║███████╗╚██████╗╚██████╔╝██║  ██║██║   ██║      ██║   
 ╚══════╝╚═╝  ╚═╝╚═╝╚══════╝   ╚═╝       ╚══════╝╚══════╝ ╚═════╝ ╚═════╝ ╚═╝  ╚═╝╚═╝   ╚═╝      ╚═╝   
                                                                                                                                                      
"@
# Charge les fichiers externes
$Scripts = @("Audit-UserAccounts", "Check-SecurityUpdates", "Check-Firewall", "Scan-Vulnerabilities", "Check-FilePermissions",
            "Monitor-FailedLogins", "Check-SystemIntegrity", "Monitor-NetworkConnections", "Generate-SecurePassword", "Check-BrowserSecurity")

foreach ($script in $Scripts) {
    $scriptPath = ".\$script.ps1"
    if (Test-Path $scriptPath) {
        . $scriptPath
    } else {
        Write-Host "⚠ Le fichier $script.ps1 est introuvable. Vérifiez son emplacement."
    }
}

function Show-Menu {
    Write-Host "`n========= MENU ========="
    Write-Host "1. Auditer les comptes utilisateurs"
    Write-Host "2. Vérifier les mises à jour de sécurité"
    Write-Host "3. Vérifier la configuration du pare-feu"
    Write-Host "4. Scanner les vulnérabilités locales"
    Write-Host "5. Vérifier les permissions des fichiers sensibles"
    Write-Host "6. Surveiller les tentatives de connexion échouées"
    Write-Host "7. Vérifier l'intégrité des fichiers système"
    Write-Host "8. Surveiller les connexions réseau"
    Write-Host "9. Générer un mot de passe sécurisé"
    Write-Host "10. Vérifier les paramètres de sécurité du navigateur"
    Write-Host "Q. Quitter"
}

function Main {
    while ($true) {
        Show-Menu
        $choice = Read-Host "Entrez votre choix"
        switch ($choice) {
            '1' { Audit-UserAccounts }
            '2' { Check-SecurityUpdates }
            '3' { Check-Firewall }
            '4' { Scan-Vulnerabilities }
            '5' { Check-FilePermissions }
            '6' { Monitor-FailedLogins }
            '7' { Check-SystemIntegrity }
            '8' { Monitor-NetworkConnections }
            '9' { Generate-SecurePassword }
            '10' { Check-BrowserSecurity }
            'Q' { Write-Host "✅ Sortie du programme..."; exit 0 }
            default { Write-Host "❌ Option invalide, réessayez !" }
        }
    }
}

Main
