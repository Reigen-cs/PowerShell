# Enhanced VLC Installation Script with Progress Bar and User Interaction

# Define the VLC installer URL and destination path
$vlcUrl = "https://get.videolan.org/vlc/last/win64/vlc-3.0.18.4-win64.exe"
$installerPath = "$env:Temp\vlc_installer.exe"

# Function to download the VLC installer
function Download-VLC {
    Write-Host "Downloading VLC installer..."
    $webClient = New-Object System.Net.WebClient

    # Define a progress bar for the download
    $webClient.DownloadProgressChanged += {
        $percent = $args[1]
        Write-Progress -PercentComplete $percent -Status "Downloading VLC..." -Activity "Progress"
    }

    # Start downloading VLC
    $webClient.DownloadFileAsync($vlcUrl, $installerPath)

    # Wait until download is complete
    while ($webClient.IsBusy) {
        Start-Sleep -Seconds 1
    }

    Write-Host "Download complete."
}

# Function to install VLC silently
function Install-VLC {
    Write-Host "Installing VLC silently..."
    Start-Process -FilePath $installerPath -ArgumentList "/S" -Wait
    Write-Host "VLC installation complete."
}

# Function to prompt the user to open VLC
function Ask-ToOpenVLC {
    $response = Read-Host "Would you like to open VLC now? (Y/N)"
    
    if ($response -match "^[Yy]$") {
        Write-Host "Opening VLC..."
        Start-Process "C:\Program Files\VideoLAN\VLC\vlc.exe"
    }
    else {
        Write-Host "VLC will not be opened."
    }
}

# Main script
try {
    # Download the installer
    Download-VLC

    # Install VLC silently
    Install-VLC

    # Ask user if they want to open VLC
    Ask-ToOpenVLC
}
catch {
    Write-Host "An error occurred: $_"
    exit
}
