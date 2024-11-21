# Define website and alert message
$Website = "https://facebook.com"

# Check website availability
try {
    Invoke-WebRequest -Uri $Website -TimeoutSec 5
    Write-Host "Website is up."
} catch {
    Write-Host "Website is down."
}