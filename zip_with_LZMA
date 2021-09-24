# To use this code, copy and paste all into the PowerShell console
# Then, press 'enter' for the code to run.

$7zipPath = "$env:ProgramFiles\7-Zip\7z.exe"

if (-not (Test-Path -Path $7zipPath -PathType Leaf)) {
    throw "7 zip file '$7zipPath' not found"
}

Set-Alias 7zip $7zipPath

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
	$target = Read-Host -Prompt "Name of zipped file (absolute/relative path, end with extension you want eg .zip or .7z)"
	$compression = Read-Host -Prompt "Set compression level, lowest = fastest but biggest file [0 | 1 | 3 | 5 | 7 | 9]"
	$method = Read-Host -Prompt "Set compression method (LZMA for .zip, LZMA2 for .7z)"
	$password = Read-Host -Prompt "Enter password (press n for no password)"

	# separated for easier maintenance
	$7zipVariables = "a", "-m0=$method", "-mx=$compression", "-mmt=8", "$target", "$source"
	$7zipVariablesWithPassword = $7zipVariables += "-p$password"

	if($password -eq "n"){& 7zip $7zipVariables}
	else {& 7zip $7zipVariablesWithPassword}
}
	"uz" {
	$toUnzip = Read-Host -Prompt "Name of zipped file to unzip (relative/absolute path)"
	7zip e $toUnzip
}
}

Read-Host -Prompt "Press Enter to exit"
