# Define services to monitor
$ServicesToMonitor = @("Spooler", "W32Time", "WinRM")

# Check the status of each service
foreach ($Service in $ServicesToMonitor) {
    $ServiceStatus = Get-Service -Name $Service

    if ($ServiceStatus.Status -ne "Running") {
        Write-Host "$Service is not running. Attempting to restart..."
        Restart-Service -Name $Service -Force
        Write-Host "$Service has been restarted."
    } else {
        Write-Host "$Service is running."
    }
}
