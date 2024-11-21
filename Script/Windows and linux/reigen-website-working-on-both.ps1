# Define website and alert message
$Website = "https://facebook.com"

# Check website availability
try {
    $Response = Invoke-WebRequest -Uri $Website -TimeoutSec 5 -ErrorAction Stop
    Write-Host "Website is up." -ForegroundColor Green
} catch {
    Write-Host "Website is down." -ForegroundColor Red
    Write-Host "Error Details: $($_.Exception.Message)"
}
