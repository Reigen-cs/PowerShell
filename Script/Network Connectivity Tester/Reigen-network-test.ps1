# Define server list and output file
$Servers = @("google.com", "github.com", "microsoft.com")
$LogFile = "C:\ConnectivityLog.txt"

# Test connectivity to each server
foreach ($Server in $Servers) {
    $PingResult = Test-Connection -ComputerName $Server -Count 2 -Quiet
    $Status = if ($PingResult) { "Reachable" } else { "Unreachable" }
    $LogEntry = "$(Get-Date): $Server is $Status"
    Add-Content -Path $LogFile -Value $LogEntry
}

Write-Host "Connectivity test results logged to $LogFile."
