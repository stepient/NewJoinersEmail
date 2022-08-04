#Set up local resources as part of the flow automating sending emails to introduce new team members
# Import variables
. "$PSScriptRoot\vars.ps1"

If (-not (Test-Path -Path $WorkingDir))
{
    New-Item -Path $WorkingDir -ItemType Directory
}

If (-not (Test-Path -Path "$WorkingDir\$NConvertZipFile"))
{
    Invoke-WebRequest -Uri $NConvertDownloadUri -OutFile "$WorkingDir\$NConvertZipFile"
    Expand-Archive -Path "$WorkingDir\$NConvertZipFile" -DestinationPath $WorkingDir
}

# Copy worker script to $WorkingDir

Copy-Item "$PSScriptRoot\$WorkerScriptName" -Destination $WorkingDir

#Create a scheduled task
$Hour = 10
$Minutes = 00
$DaysOfWeek = "Monday", "Tuesday", "Wednesday", "Thursday", "Friday"
$User = $env:USERNAME
$ScriptPath = "`"$WorkingDir\$WorkerScriptName`""
#$TaskName =  see vars.ps1
	
[datetime]$Time = $Hour.ToString() + ':' + $Minutes.ToString()
$Trigger  = New-ScheduledTaskTrigger -At $Time -Weekly -DaysOfWeek $DaysOfWeek
$Action   = New-ScheduledTaskAction -Execute "PowerShell.exe" -Argument "-File $ScriptPath"
$Settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -StartWhenAvailable -Hidden
	    
$Params = @{
	TaskName    = $TaskName
	Trigger     = $Trigger
	User        = $User
	Action      = $Action
	RunLevel    = "Limited"
	Description = "This task runs the script that sets the DPI of all images in the working directory to 96."
	Force       = $true
    Settings    = $Settings
}

Register-ScheduledTask @Params
pause

