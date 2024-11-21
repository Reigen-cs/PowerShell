# Define the Notepad++ installer URL and destination path
$notepadPlusPlusUrl = "https://github.com/notepad-plus-plus/notepad-plus-plus/releases/download/v8.4.8/npp.8.4.8.Installer.x64.exe"  # Official Notepad++ mirror
$installerPath = "$env:Temp\npp_installer.exe"

# Function to download the Notepad++ installer with a progress bar
function Download-NotepadPlusPlus {
    Write-Host "Downloading Notepad++ installer..."

    try {
        # Use Invoke-WebRequest to download the file without relying on Content-Length
        $webClient = New-Object System.Net.WebClient
        $webClient.DownloadFile($notepadPlusPlusUrl, $installerPath)

        Write-Host "Download complete."
    }
    catch {
        Write-Host "An error occurred while downloading the file: $_"
        exit
    }
}

# Function to install Notepad++ silently
function Install-NotepadPlusPlus {
    Write-Host "Installing Notepad++ silently..."
    Start-Process -FilePath $installerPath -ArgumentList "/S" -Wait
    Write-Host "Notepad++ installation complete."
}

# Function to prompt the user to open Notepad++
function Ask-ToOpenNotepadPlusPlus {
    $response = Read-Host "Would you like to open Notepad++ now? (Y/N)"
    
    if ($response -match "^[Yy]$") {
        Write-Host "Opening Notepad++..."
        Start-Process "C:\Program Files\Notepad++\notepad++.exe"
    }
    else {
        Write-Host "Notepad++ will not be opened."
    }
}

# Main script
try {
    # Download the installer
    Download-NotepadPlusPlus

    # Install Notepad++ silently
    Install-NotepadPlusPlus

    # Ask user if they want to open Notepad++
    Ask-ToOpenNotepadPlusPlus
}
catch {
    Write-Host "An error occurred: $_"
    exit
}
