# To use this code, copy and paste all into the PowerShell console
# Then, press 'enter' for the code to run.

# from https://stackoverflow.com/questions/25287994/running-7-zip-from-within-a-powershell-script
# https://documentation.help/7-Zip/method.htm

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
	$compression = Read-Host -Prompt "Set compression level, lowest = fastest but biggest file [0 | 1 | 3 | 5 | 7 | 9]"
	$password = Read-Host -Prompt "Enter password (press n for no password)"
	if($password -eq "n"){7zip a -mx="$compression" $target $source}
	else {7zip a -mx="$compression" $target $source -p"$password"}
}
	"uz" {
	$toUnzip = Read-Host -Prompt "Name of zipped file to unzip (relative path, zippedfile.zip)"
	7zip e $toUnzip
}
}
