# Initialize arrays for CPU and memory usage
$CpuUsage = @()
$MemoryUsage = @()

# Monitor system resources every 2 seconds for 10 iterations
for ($i = 1; $i -le 10; $i++) {
    $Cpu = Get-Counter -Counter "\Processor(_Total)\% Processor Time" | Select-Object -ExpandProperty CounterSamples | Select-Object -ExpandProperty CookedValue
    $Memory = Get-Counter -Counter "\Memory\Available MBytes" | Select-Object -ExpandProperty CounterSamples | Select-Object -ExpandProperty CookedValue

    $CpuUsage += [math]::Round($Cpu, 2)
    $MemoryUsage += [math]::Round($Memory, 2)

    Start-Sleep -Seconds 2
}

# Generate a graph using ASCII art
Write-Host "CPU Usage: "
$CpuUsage | ForEach-Object { "*" * ([math]::Round($_ / 10)) }

Write-Host "Memory Usage (MB): "
$MemoryUsage | ForEach-Object { "*" * ([math]::Round($_ / 100)) }
