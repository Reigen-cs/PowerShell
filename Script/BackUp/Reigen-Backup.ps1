# Enhanced Backup Script with progress bar, log, and timestamped folder

# Define source and destination
$source = "C:\Users\YourUserName\Documents"  # Change this to the source folder
$destinationRoot = "D:\Backups"             # Change this to your destination path

# Create a timestamp for the backup folder
$timestamp = Get-Date -Format "yyyy-MM-dd_HH-mm-ss"
$destination = "$destinationRoot\Backup_$timestamp"

# Check if the source exists
if (-not (Test-Path $source)) {
    Write-Host "Source folder does not exist. Exiting."
    exit
}

# Create the backup destination folder with the timestamp
New-Item -ItemType Directory -Path $destination | Out-Null

# Create a log file for the backup
$logFile = "$destination\backup_log.txt"
"Backup started at $(Get-Date)" | Out-File -FilePath $logFile

# Start the backup with progress
Write-Host "Starting backup from $source to $destination..."
$files = Get-ChildItem -Path $source -Recurse
$totalFiles = $files.Count
$currentFile = 0

# Loop through each file and copy
foreach ($file in $files) {
    $currentFile++
    $progressPercent = ($currentFile / $totalFiles) * 100
    Write-Progress -PercentComplete $progressPercent -Status "Backing up..." -Activity "$currentFile of $totalFiles files"

    try {
        # Copy the file with overwrite enabled (add -Force if needed)
        $destinationPath = "$destination\$($file.FullName.Substring($source.Length))"
        if (-not (Test-Path (Split-Path $destinationPath))) {
            New-Item -ItemType Directory -Path (Split-Path $destinationPath) | Out-Null
        }
        Copy-Item -Path $file.FullName -Destination $destinationPath -Force

        # Log each file backed up
        "$($file.FullName) - $(Get-Date)" | Out-File -FilePath $logFile -Append
    }
    catch {
        Write-Host "Error copying file: $($file.FullName)"
        "$($file.FullName) - ERROR: $_" | Out-File -FilePath $logFile -Append
    }
}

# Complete the progress bar and display a success message
Write-Progress -PercentComplete 100 -Status "Backup Complete" -Activity "All files backed up"
Write-Host "Backup completed successfully!"

# Log the end of the backup
"Backup completed at $(Get-Date)" | Out-File -FilePath $logFile -Append
Write-Host "Backup log saved at $logFile"
