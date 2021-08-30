# To use this code, copy and paste all into the PowerShell console
# Then, press 'enter' for the code to run.
# If you can run ps1 files directly, then just run the file via the console (.\7zip_unzip_function.ps1),
# and then you can use the function straight away.

# from https://stackoverflow.com/questions/25287994/running-7-zip-from-within-a-powershell-script
# expected call format:
# successful:
#	SevenZip -z -source "folder_or_file_to_zip" -target "zippedfile.zip" -p "password"
#	SevenZip -uz -source "file_to_unzip" -p "password"
#
# extra prompts:
#	SevenZip -z -source "file_to_zip"

function SevenZip {
	[CmdletBinding(DefaultParameterSetName = "help")]
	param
	(
		[Parameter(Mandatory=$false, ParameterSetName="help")][switch]$help,
		[Parameter(Mandatory=$false, ParameterSetName = "z")][switch] $z,
		[Parameter(Mandatory=$false, ParameterSetName="uz")][switch] $uz,
		[Parameter(Mandatory=$true, ParameterSetName="z")]
		[Parameter(Mandatory=$true, ParameterSetName="uz")]
		[string] $source,
		[Parameter(Mandatory=$true, ParameterSetName="z")]
		[Parameter(Mandatory=$false, ParameterSetName="uz")]
		[string]$target,
		[Parameter(Mandatory=$false)][string]$p
	)
	
	if((-not($z) -and -not($uz)) -or ($help)){
		Write-Host "Expected call format, for zipping:" -ForegroundColor green
		Write-Host 'SevenZip -z -source "file_to_zip" -target "zippedfile.zip" -p "password"'
		Write-Host "Expected call format, for unzipping:" -ForegroundColor green
		Write-Host 'SevenZip -uz -source "file_to_unzip" -p "password"'
		Write-Host "But if you mess up, the program will prompt you for missing inputs. No need for quotation marks for inputs in that case." -ForegroundColor green
		Write-Host "Type SevenZip or SevenZip -help to return to this screen." -ForegroundColor green
	}

	$7zipPath = "$env:ProgramFiles\7-Zip\7z.exe"

	if (-not (Test-Path -Path $7zipPath -PathType Leaf)) {
		throw "7 zip file '$7zipPath' not found"
	}

	Set-Alias 7zip $7zipPath

	if($z -and $p){7zip a -mx=9 $target $source -p"$p"}
	if($z -and -not($p)){7zip a -mx=9 $target $source}
	if($uz -and $p){7zip e $source -p"$p"}
	if($uz -and -not($p)){7zip e $source}
}
