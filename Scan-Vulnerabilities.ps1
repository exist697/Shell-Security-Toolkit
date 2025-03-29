function Scan-Vulnerabilities {
    Write-Host "`n🔎 Scan approfondi des ports ouverts..." -ForegroundColor Cyan

    # Liste de ports random
    $portsToScan = @(21, 22, 23, 25, 80, 110, 135, 139, 143, 443, 445, 3389)
    $results = foreach ($port in $portsToScan) {
        $test = Test-NetConnection -ComputerName localhost -Port $port -WarningAction SilentlyContinue
        [PSCustomObject]@{
            Port        = $port
            TcpTestSucceeded = $test.TcpTestSucceeded
            RemoteAddress = $test.RemoteAddress
            ProcessId   = (Get-NetTCPConnection -LocalPort $port -ErrorAction SilentlyContinue | Select-Object -First 1).OwningProcess
        }
    }
    $results | Format-Table -AutoSize
    Write-Host "`nAnalyse des résultats : Les ports ouverts indiquent des services actifs. Vérifie que chaque service est légitime." -ForegroundColor Yellow
}
