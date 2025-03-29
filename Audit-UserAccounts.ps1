function Audit-UserAccounts {
    Write-Host "`n🔎 Audit complet des comptes utilisateurs..." -ForegroundColor Cyan
    $users = Get-LocalUser | ForEach-Object {
        $user = $_
        # Récupération des groupes auxquels l'utilisateur appartient
        $groups = (Get-LocalGroup | Where-Object {
            (Get-LocalGroupMember -Group $_.Name -ErrorAction SilentlyContinue | Where-Object { $_.Name -eq $user.Name })
        }).Name -join ", "

        # Vérifier si l'utilisateur fait partie du groupe Administrateurs
        $isAdmin = if ($groups -match "Administrateurs") { "Oui" } else { "Non" }

        # Vérifier les options du mot de passe (par ex., expiration ou changement obligatoire)
        try {
            $userAccount = ([ADSI]"WinNT://$env:COMPUTERNAME/$($user.Name),user")
            $passwordExpired = $userAccount.PasswordExpired
            $passwordChangeRequired = $userAccount.PasswordRequired -and ($userAccount.UserFlags -band 0x80000)
        } catch {
            $passwordExpired = $null
            $passwordChangeRequired = $null
        }

        [PSCustomObject]@{
            Nom                     = $user.Name
            Actif                   = $user.Enabled
            DernierLogon            = $user.LastLogon
            Administrateur          = $isAdmin
            MotDePasseExpire        = $passwordExpired
            ChangementMotDePasse    = $passwordChangeRequired
            Groupes                 = $groups
        }
    }
    if ($users) {
        $users | Format-Table -AutoSize
    } else {
        Write-Host "Aucun utilisateur trouvé." -ForegroundColor Yellow
    }
}
