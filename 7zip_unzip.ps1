# If you can't run ps1 files, to still use this code,
# copy and paste all into the PowerShell console.
# Then, press 'enter' for the code to run.
# If you are able to run ps1 files, then just run this file directly.

# from https://stackoverflow.com/questions/25287994/running-7-zip-from-within-a-powershell-script
$7zipPath = "$env:ProgramFiles\7-Zip\7z.exe"

if (-not (Test-Path -Path $7zipPath -PathType Leaf)) {
    throw "7 zip file '$7zipPath' not found"
}

Set-Alias 7zip $7zipPath

# from https://www.educba.com/powershell-prompt-for-input/
Write-Host "Press enter for next input" -ForegroundColor Green

$zipOrUnzip = Read-Host -Prompt "Zip or unzip? (z/uz)"

While(($zipOrUnzip -ne "z") -and ($zipOrUnzip -ne "uz"))
{
	$zipOrUnzip = Read-Host -Prompt "Oops, try again"
	Write-Host $zipOrUnzip
}

Write-Host "To restart, press Ctrl + C and repaste the code into the console." -ForegroundColor Green
Switch($zipOrUnzip)
{
	"z" {
	$source = Read-Host -Prompt "Name of file/folder to zip (absolute/relative path, accepts one file or folder)"
	$target = Read-Host -Prompt "Name of zipped file (absolute/relative path, end with extension you want eg .zip)"
	$password = Read-Host -Prompt "Enter password (press n for no password)"
	if($password -eq "n"){7zip a -mx=9 $target $source}
	else {7zip a -mx=9 $target $source -p"$password"}
}
	"uz" {
	$toUnzip = Read-Host -Prompt "Name of zipped file to unzip (relative path, zippedfile.zip)"
	7zip e $toUnzip
}
}
