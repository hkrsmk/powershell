# references:
# https://stackoverflow.com/questions/36220782/compare-2-csv-files-and-write-all-differences
# https://stackoverflow.com/questions/25764366/how-to-get-the-value-of-header-in-csv
# https://stackoverflow.com/questions/18259861/compare-object-not-working-if-i-dont-list-the-properties

# example function call:
# CompareCsv -first_file "1.csv" -second_file "3.csv"

Write-Host "Example function call:" -ForegroundColor green
Write-Host "CompareCsv -first_file '1.csv' -second_file '3.csv'" -ForegroundColor green

function CompareCsv {
	param (
		$first_file,
		$second_file
		)
	$first_import = Import-Csv -Path $first_file
	$second_import = Import-Csv -Path $second_file

	# all column names:
	$column_names = $first_import[0].psobject.properties.name

	ForEach ($column in $column_names)
	{
		$results = Compare-Object -ReferenceObject $first_import -DifferenceObject $second_import -Property "$column" -CaseSensitive | Format-Table -AutoSize
	# ForEach-Object can't be used. So I didn't bother with making columns nicer.
	# Error: PropertySetterNotSupportedInConstrainedLanguage
	#	$results | ForEach-Object -Process {
	#		if ($_.SideIndicator -eq "<="){
	#			$_.SideIndicator = $first_file
	#			Write-Host "I'm lefty"
	#		}
	#		elseif ($_.SideIndicator -eq "=>"){$_.SideIndicator = $second_file}
	#	}
	
	Write-Output -InputObject $results
	}
	
	Write-Host "'<=' refers to $first_file and '=>' refers to $second_file."
	Write-Host "Equal values are not shown."
}
