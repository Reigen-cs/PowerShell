# Define folder path
$FolderPath = "C:\TextFiles"
$Date = (Get-Date).ToString("yyyy-MM-dd")

# Rename all .txt files in the folder
Get-ChildItem -Path $FolderPath -Filter "*.txt" | ForEach-Object {
    $NewName = "$($_.BaseName)_$Date$($_.Extension)"
    Rename-Item -Path $_.FullName -NewName $NewName
}

Write-Host "Files renamed successfully."
