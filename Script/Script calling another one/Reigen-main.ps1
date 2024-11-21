# Define the path to the child script
$ChildScript = "C:\Scripts\ChildScript.ps1"

# Parameters to pass to the child script
$Name = "John Doe"
$Age = 30

# Call the child script and capture its output
$Output = & $ChildScript -Name $Name -Age $Age

Write-Host "Output from Child Script: $Output"
