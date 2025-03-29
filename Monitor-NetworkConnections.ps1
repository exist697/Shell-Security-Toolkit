function Monitor-NetworkConnections {
    param (
        [string[]]$blacklist = @("192.168.1.100", "8.8.8.8")
    )

    $connections = Get-NetTCPConnection | Select-Object LocalAddress, RemoteAddress, State

    $connections | ForEach-Object {
        $isSuspicious = "Non"
        if ($blacklist -contains $_.RemoteAddress) {
            $isSuspicious = "Oui"
        }

        [PSCustomObject]@{
            LocalAddress  = $_.LocalAddress
            RemoteAddress = $_.RemoteAddress
            State        = $_.State
            Suspicious   = $isSuspicious
        }
    } | Format-Table -AutoSize
}

