function Check-FilePermissions {
    Write-Host "`n🛡️ Analyse approfondie des permissions des fichiers sensibles..." -ForegroundColor Cyan

    # Liste des chemins sensibles à analyser
    $paths = @(
        "C:\Windows\System32",
        "C:\Windows\SysWOW64",
        "C:\Windows\WinSxS"
    )
    foreach ($path in $paths) {
        Write-Host "`n>> Vérification des permissions pour : $path" -ForegroundColor Green
        try {
            $acl = Get-Acl -Path $path -ErrorAction Stop
            $insecure = $acl.Access | Where-Object { $_.IdentityReference -match "Everyone|Guests" -and ($_.FileSystemRights -match "Write") }
            if ($insecure) {
                Write-Host "Attention : Des permissions potentiellement dangereuses ont été trouvées !" -ForegroundColor Red
                $insecure | Format-Table IdentityReference, FileSystemRights, AccessControlType -AutoSize
            } else {
                Write-Host "Les permissions semblent conformes pour $path." -ForegroundColor Green
            }
        } catch {
            Write-Host "Erreur lors de la lecture des permissions de $path" -ForegroundColor Red
        }
    }
}
