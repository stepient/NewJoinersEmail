param(
    [switch]$RemoveParent = $true
)

. "$PSScriptRoot\vars.ps1"

#Remove working directory
$ParentDir = (Get-Item $WorkingDir).Parent.FullName

If (Test-Path -Path $WorkingDir)
{
    Remove-Item -Path $WorkingDir -Recurse -Force -Confirm:$false
}

If (Test-Path -Path $ParentDir)
{
    Remove-Item -Path $ParentDir -Recurse -Force -Confirm:$false
}

# Remove scheduled task
Unregister-ScheduledTask -TaskName $TaskName -Confirm:$false
