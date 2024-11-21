# Version 2: Interactive Monitoring script

# Function to get CPU usage
function Get-CPUUsage {
    $cpuUsage = Get-Counter '\Processor(_Total)\% Processor Time'
    Write-Host "---- CPU Usage: $($cpuUsage.CounterSamples[0].CookedValue)%"
}

# Function to get memory usage
function Get-MemoryUsage {
    $memoryUsage = Get-WmiObject -Class Win32_OperatingSystem | Select-Object -ExpandProperty FreePhysicalMemory
    $totalMemory = Get-WmiObject -Class Win32_OperatingSystem | Select-Object -ExpandProperty TotalVisibleMemorySize
    $memoryUsed = $totalMemory - $memoryUsage
    Write-Host "---- Memory Usage: $([math]::round(($memoryUsed / 1MB), 2)) MB / $([math]::round(($totalMemory / 1MB), 2)) MB"
}

# Function to get disk usage
function Get-DiskUsage {
    $diskUsage = Get-WmiObject -Class Win32_LogicalDisk | Where-Object {$_.DriveType -eq 3} | Select-Object DeviceID, @{Name='Used Space (GB)';Expression={[math]::round($_.Size / 1GB, 2)}}, @{Name='Free Space (GB)';Expression={[math]::round($_.FreeSpace / 1GB, 2)}}
    Write-Host "---- Disk Usage:"
    $diskUsage | ForEach-Object {Write-Host "$($_.DeviceID): $($_.'Used Space (GB)') GB used, $($_.'Free Space (GB)') GB free"}
}

# Function to get network usage
function Get-NetworkUsage {
    $networkUsage = Get-Counter '\Network Interface(*)\Bytes Total/sec'
    Write-Host "---- Network Usage: $($networkUsage.CounterSamples[0].CookedValue) bytes/sec"
}

# Menu for user input
Write-Host "Select the information you want to see:"
Write-Host "1. CPU Usage"
Write-Host "2. Memory Usage"
Write-Host "3. Disk Usage"
Write-Host "4. Network Usage"
Write-Host "5. All of the above"
$choice = Read-Host "Enter your choice (1-5)"

switch ($choice) {
    1 { Get-CPUUsage }
    2 { Get-MemoryUsage }
    3 { Get-DiskUsage }
    4 { Get-NetworkUsage }
    5 { 
        Get-CPUUsage
        Get-MemoryUsage
        Get-DiskUsage
        Get-NetworkUsage
    }
    default { Write-Host "Invalid choice. Please enter a number between 1 and 5." }
}
