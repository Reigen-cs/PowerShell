# Load the necessary assembly for Windows Forms
Add-Type -AssemblyName 'System.Windows.Forms'

# Create OpenFileDialog
$FileDialog = New-Object System.Windows.Forms.OpenFileDialog
$FileDialog.Filter = "All files (*.*)|*.*"
$FileDialog.Multiselect = $true

if ($FileDialog.ShowDialog() -eq [System.Windows.Forms.DialogResult]::OK) {
    $SelectedFiles = $FileDialog.FileNames

    # Create FolderBrowserDialog
    $FolderDialog = New-Object System.Windows.Forms.FolderBrowserDialog
    if ($FolderDialog.ShowDialog() -eq [System.Windows.Forms.DialogResult]::OK) {
        $DestinationFolder = $FolderDialog.SelectedPath

        # Copy selected files to destination
        foreach ($File in $SelectedFiles) {
            Copy-Item -Path $File -Destination $DestinationFolder
        }

        Write-Host "Files copied successfully to $DestinationFolder"
    }
}
