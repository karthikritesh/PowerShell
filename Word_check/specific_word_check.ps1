$Destination = 'C:\Users\m1056988\Desktop'
$SearchText = 'error'
$Excel = New-Object -ComObject Excel.Application

$Files = Get-ChildItem "$env:C:\Users\m1056988\Desktop\2.xlsx" | Select -Expand FullName
$counter = 1
ForEach($File in $Files){
    Write-Progress -Activity "Checking: $file" -Status "File $counter of $($files.count)" -PercentComplete ($counter*100/$files.count)
    $Workbook = $Excel.Workbooks.Open($File)
$var= ($Workbook.Sheets.Item(1).Range("A:Z").Find($SearchText))
    If($var) 
	{
	$SearchText.count
	write-host "no domains reported error in 1st file"
	}
    else{
    write-host "error found"
    }
    $workbook.close($false)
    $counter++
}
