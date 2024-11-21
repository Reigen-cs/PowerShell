# Define file paths and encryption key
$FilePath = "C:\SensitiveData.txt"
$EncryptedFile = "C:\EncryptedData.txt"
$DecryptedFile = "C:\DecryptedData.txt"
$Key = (New-Object Security.Cryptography.RNGCryptoServiceProvider).GetBytes(32)

# Encrypt the file
$Content = Get-Content -Path $FilePath -Raw
$EncryptedContent = [Convert]::ToBase64String([System.Security.Cryptography.ProtectedData]::Protect([Text.Encoding]::UTF8.GetBytes($Content), $Key, 'CurrentUser'))
Set-Content -Path $EncryptedFile -Value $EncryptedContent

Write-Host "File encrypted successfully."

# Decrypt the file
$DecryptedContent = [Text.Encoding]::UTF8.GetString([System.Security.Cryptography.ProtectedData]::Unprotect([Convert]::FromBase64String($EncryptedContent), $Key, 'CurrentUser'))
Set-Content -Path $DecryptedFile -Value $DecryptedContent

Write-Host "File decrypted successfully."
