# Define log file and firewall rule name
$LogFilePath = "C:\WebServerLogs.txt"
$RuleName = "BlockMaliciousIPs"

# Define malicious IP detection criteria
$MaliciousIPs = Select-String -Path $LogFilePath -Pattern "403" | ForEach-Object {
    ($_ -match '\d+\.\d+\.\d+\.\d+') | Out-Null
    $Matches[0]
} | Select-Object -Unique

# Block detected IPs in Windows Firewall
foreach ($IP in $MaliciousIPs) {
    New-NetFirewallRule -DisplayName "$RuleName - $IP" -Direction Inbound -Action Block -RemoteAddress $IP
}

Write-Host "Malicious IPs blocked in Windows Firewall."
