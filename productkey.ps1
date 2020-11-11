$digitalproductid = Get-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\' | select DigitalProductId -ExpandProperty DigitalProductId
$base24key = $digitalproductid[66..52]

if( ($base24key[0] -band 0x8) -eq 0x8)
{
	#New style key, with an N in it
	$base24key[0] = $base24key[0] -band 0x7
	$containsN = $true
}

$digits = 'B','C','D','F','G','H','J','K','M','P','Q','R','T','V','W','X','Y','2','3','4','6','7','8','9'

[bigint]$bignum = 0
foreach($num in $base24key)
{
	$bignum = ($bignum -shl 8) -bor $num
}

$key = foreach($i in 1..25)
{
	$digits[$bignum % 24]
	$bignum /= 24
	if( ($i % 5 -eq 0) -and ($i -ne 25)){'-'}
}

[array]::reverse($key)

if($containsN)
{
	$npos = $digits.IndexOf($key[0])
	for($i = 0; $i -lt $npos; $i++)
	{
		$key[$i] = $key[$i+1]
	}
	$key[$npos] = 'N'
}

$key -join ''
