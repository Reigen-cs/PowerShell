# Version 1: Monitoring system information directly

# Get CPU usage
$cpuUsage = Get-Counter '\Processor(_Total)\% Processor Time'

# Get memory usage
$memoryUsage = Get-WmiObject -Class Win32_OperatingSystem | Select-Object -ExpandProperty FreePhysicalMemory
$totalMemory = Get-WmiObject -Class Win32_OperatingSystem | Select-Object -ExpandProperty TotalVisibleMemorySize
$memoryUsed = $totalMemory - $memoryUsage

# Get disk usage
$diskUsage = Get-WmiObject -Class Win32_LogicalDisk | Where-Object {$_.DriveType -eq 3} | Select-Object DeviceID, @{Name='Used Space (GB)';Expression={[math]::round($_.Size / 1GB, 2)}}, @{Name='Free Space (GB)';Expression={[math]::round($_.FreeSpace / 1GB, 2)}}

# Get network usage
$networkUsage = Get-Counter '\Network Interface(*)\Bytes Total/sec'

# Output results
Write-Host "---- CPU Usage: $($cpuUsage.CounterSamples[0].CookedValue)%"
Write-Host "---- Memory Usage: $([math]::round(($memoryUsed / 1MB), 2)) MB / $([math]::round(($totalMemory / 1MB), 2)) MB"
Write-Host "---- Disk Usage:"
$diskUsage | ForEach-Object {Write-Host "$($_.DeviceID): $($_.'Used Space (GB)') GB used, $($_.'Free Space (GB)') GB free"}
Write-Host "---- Network Usage: $($networkUsage.CounterSamples[0].CookedValue) bytes/sec"
