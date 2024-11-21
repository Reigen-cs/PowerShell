# Define website and alert email
$Website = "https://example.com"
$AlertEmail = "admin@domain.com"

# Check website availability
try {
    Invoke-WebRequest -Uri $Website -TimeoutSec 5
    Write-Host "Website is up."
} catch {
    Write-Host "Website is down. Sending alert email..."
    Send-MailMessage -To $AlertEmail -From "monitor@domain.com" -Subject "Website Down Alert" `
        -Body "$Website is not responding." -SmtpServer "smtp.domain.com"
}
