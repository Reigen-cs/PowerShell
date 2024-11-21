# Define CPU and memory thresholds
$CpuThreshold = 80
$MemoryThreshold = 500MB

# Find and terminate resource-intensive processes
Get-Process | Where-Object { $_.CPU -gt $CpuThreshold -or $_.WorkingSet -gt $MemoryThreshold } | 
    ForEach-Object {
        Write-Host "Terminating process: $($_.Name)"
        Stop-Process -Id $_.Id -Force
    }
