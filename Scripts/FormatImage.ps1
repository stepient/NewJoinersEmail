#This script changes DPI of all jpg images in the working directory to 96.
#If the file name ends in _1.jpg or _DPI96.jpg, it is skipped

$WorkingDir = $PSScriptRoot
$NConvertDir = (Get-ChildItem $WorkingDir\NConvert* -Directory).FullName

$SourceFileExtension = "jpg"

$FilesToConvert = Get-ChildItem -Path $WorkingDir\* -Include '*.jpg' -Exclude "*_1.jpg", "*_DPI96.jpg"

Foreach ($File in $FilesToConvert)
{

    $ConvertedFile = $File.BaseName + '_1.' + $SourceFileExtension
    $NewName = $File.BaseName + '_DPI96.' + $SourceFileExtension

    If(-not $(Test-Path "$WorkingDir\$ConvertedFile"))
    {

        Set-Location $NConvertDir    
        .\nconvert.exe -out jpeg -dpi 96 -keepdocsize -keepfiledate $File.FullName

        If(-not (Test-Path "$WorkingDir\$NewName"))
        {
            Rename-Item $WorkingDir\$ConvertedFile -NewName $NewName
            Remove-Item -Path $File.FullName
        }
    }
}
