$WorkingDir = "$env:SystemDrive\Users\$env:USERNAME\OneDrive - Capgemini\Documents\PowerAutomate\NewJoiners"
$NConvertDownloadUri = "https://download.xnview.com/NConvert-win64.zip"
$NConvertZipFile = (Select-String -InputObject $NConvertDownloadUri -Pattern '[^/]*$').Matches.Value
$WorkerScriptName = "FormatImage.ps1"
$TaskName = "Convert Images to DPI96"
