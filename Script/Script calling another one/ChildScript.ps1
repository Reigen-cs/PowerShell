param (
    [string]$Name,
    [int]$Age
)

# Process the parameters
$Message = "Hello, $Name! You are $Age years old."
Write-Output $Message
