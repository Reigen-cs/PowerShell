# Define update interval in seconds
$Interval = 2

while ($true) {
    Clear-Host
    Write-Host "System Health Dashboard" -ForegroundColor Green

    # Display CPU and Memory usage
    $CPU = Get-Counter -Counter "\Processor(_Total)\% Processor Time" | Select-Object -ExpandProperty CounterSamples
    $Memory = Get-CimInstance -ClassName Win32_OperatingSystem | Select-Object TotalVisibleMemorySize, FreePhysicalMemory
    $UsedMemory = [math]::Round(($Memory.TotalVisibleMemorySize - $Memory.FreePhysicalMemory) / 1MB, 2)

    Write-Host "CPU Usage: $($CPU.CookedValue)%" -ForegroundColor Yellow
    Write-Host "Memory Usage: $UsedMemory MB" -ForegroundColor Cyan

    # Display Disk Space
    Get-CimInstance -ClassName Win32_LogicalDisk -Filter "DriveType=3" | ForEach-Object {
        Write-Host "$($_.DeviceID): $([math]::Round($_.FreeSpace / 1GB, 2)) GB free"
    }

    # Pause before updating
    Start-Sleep -Seconds $Interval
}
