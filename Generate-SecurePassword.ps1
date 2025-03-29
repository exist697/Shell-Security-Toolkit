function Generate-SecurePassword {
    Write-Host "`n🔐 Génération avancée d'un mot de passe sécurisé..." -ForegroundColor Cyan

    # Demander à l'utilisateur les critères
    $length = Read-Host "Entrez la longueur souhaitée (minimum 12)"
    if ($length -lt 12) { $length = 12 }
    $nbSpecial = Read-Host "Nombre de caractères spéciaux"
    
    # Définir des ensembles de caractères
    $upper = [char[]]"ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    $lower = [char[]]"abcdefghijklmnopqrstuvwxyz"
    $digits = [char[]]"0123456789"
    $special = [char[]]"!@#$%^&*()-_=+[]{};:,.<>/?"
    
    $allChars = $upper + $lower + $digits + $special
    $password = @()
    
    # Forcer la présence de caractères spéciaux
    for ($i = 0; $i -lt $nbSpecial; $i++) {
        $password += $special | Get-Random
    }
    # Compléter avec des caractères aléatoires
    for ($i = $password.Count; $i -lt $length; $i++) {
        $password += $allChars | Get-Random
    }
    
    # Mélanger le tableau et créer le mot de passe final
    $finalPassword = -join ($password | Get-Random -Count $password.Count)
    
    Write-Host "Mot de passe généré : $finalPassword" -ForegroundColor Green

    # Vérification basique de robustesse (nombre de types de caractères présents)
    $criteria = 0
    if ($finalPassword -match "[A-Z]") { $criteria++ }
    if ($finalPassword -match "[a-z]") { $criteria++ }
    if ($finalPassword -match "[0-9]") { $criteria++ }
    if ($finalPassword -match "[!@#\$%\^&\*\(\)\-_=\+\[\]\{\};:,.<>\/\?]") { $criteria++ }
    if ($criteria -lt 3) {
        Write-Host "Attention : Le mot de passe pourrait être amélioré en complexité." -ForegroundColor Yellow
    } else {
        Write-Host "Le mot de passe semble robuste." -ForegroundColor Green
    }
}
