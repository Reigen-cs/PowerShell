# Version 1: Monitoring system information directly

# Get CPU usage
$cpuUsage = Get-Counter -Counter '\Processor Information(_Total)\% Processor Time' -ErrorAction SilentlyContinue
if ($cpuUsage) {
    $cpuUsageValue = $cpuUsage.CounterSamples[0].CookedValue
    Write-Host "---- CPU Usage: $([math]::round($cpuUsageValue, 2))%"
} else {
    Write-Host "---- CPU Usage: Data not available"
}

# Get memory usage
$memoryUsage = Get-WmiObject -Class Win32_OperatingSystem | Select-Object -ExpandProperty FreePhysicalMemory
$totalMemory = Get-WmiObject -Class Win32_OperatingSystem | Select-Object -ExpandProperty TotalVisibleMemorySize
$memoryUsed = $totalMemory - $memoryUsage

Write-Host "---- Memory Usage: $([math]::round(($memoryUsed / 1MB), 2)) MB / $([math]::round(($totalMemory / 1MB), 2)) MB"

# Get disk usage
$diskUsage = Get-WmiObject -Class Win32_LogicalDisk | Where-Object {$_.DriveType -eq 3} | Select-Object DeviceID, @{Name='Used Space (GB)';Expression={[math]::round($_.Size / 1GB, 2)}}, @{Name='Free Space (GB)';Expression={[math]::round($_.FreeSpace / 1GB, 2)}}

Write-Host "---- Disk Usage:"
$diskUsage | ForEach-Object {Write-Host "$($_.DeviceID): $($_.'Used Space (GB)') GB used, $($_.'Free Space (GB)') GB free"}

# Get network usage
$networkUsage = Get-Counter -Counter '\Network Interface(*)\Bytes Total/sec' -ErrorAction SilentlyContinue
if ($networkUsage) {
    Write-Host "---- Network Usage: $([math]::round($networkUsage.CounterSamples[0].CookedValue, 2)) bytes/sec"
} else {
    Write-Host "---- Network Usage: Data not available"
}
