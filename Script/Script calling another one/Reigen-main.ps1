# Define the path to the child script
$ChildScript = "PATH/TO/ChildScript.ps1"

# Ask the user for their name and age
$Name = Read-Host "Please enter your name"
$Age = Read-Host "Please enter your age"

# Call the child script and capture its output, passing the user input as arguments
$Output = & $ChildScript -Name $Name -Age $Age

Write-Host "Output from Child Script: $Output"
