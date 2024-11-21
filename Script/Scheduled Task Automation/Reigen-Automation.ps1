# Define the task name and script path
$TaskName = "DailyScriptTask"
$ScriptPath = "C:\Scripts\DailyScript.ps1"
$TriggerTime = "08:00"

# Define the task trigger (daily at a specific time)
$Trigger = New-ScheduledTaskTrigger -Daily -At $TriggerTime

# Define the action (run the PowerShell script)
$Action = New-ScheduledTaskAction -Execute "PowerShell.exe" -Argument "-File $ScriptPath"

# Register the scheduled task
Register-ScheduledTask -TaskName $TaskName -Trigger $Trigger -Action $Action -Description "Runs a daily PowerShell script."
