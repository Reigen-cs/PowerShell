# Define the services
$services = @("Spooler", "W32Time", "WinRM")

# Function to stop and start services
function Stop-Start-Service {
    param (
        [string]$ServiceName
    )
    
    # Stop the service if it's running
    if ((Get-Service $ServiceName).Status -eq 'Running') {
        Write-Host "$ServiceName is running. Stopping the service..."
        Stop-Service -Name $ServiceName -Force
        Write-Host "$ServiceName has been stopped."
    }
    
    # Start the service
    Start-Service -Name $ServiceName
    Write-Host "$ServiceName has been restarted."
}

# Stop and start each service
foreach ($service in $services) {
    Stop-Start-Service -ServiceName $service
}
