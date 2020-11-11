#The 24 character Windows Product Key alphabet
$digits = 'B','C','D','F','G','H','J','K','M','P','Q','R','T','V','W','X','Y','2','3','4','6','7','8','9'

#Grab the 15 bytes out of DigitalProductId that contain the product key. Stored little-endian, so flip it for easier math
$digitalproductid = Get-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\' | select DigitalProductId -ExpandProperty DigitalProductId
$base24key = $digitalproductid[66..52]

#Check the new-style key flag, stored in the 116th bit. We reversed the order, so the highest order byte is now in front.
if($base24key[0] -band 0x8)
{
	#New style key, with an 'N' in it. Remove all data after the 115th bit.
	$containsN = $true
	$base24key[0] = $base24key[0] -band 0x7
}

#Store the bytes as a BigInteger for easy math
[bigint]$bignum = 0
foreach($num in $base24key)
{
	$bignum = ($bignum -shl 8) -bor $num
}

#Pull out each digit (which will be in reverse order)
$keyarray = foreach($i in 1..25)
{
	$digits[$bignum % 24]
	$bignum /= 24
}

#Reverse the array to get the correct order and convert to a string
[array]::reverse($keyarray)
$productkey = $keyarray -join ''

#If this is a new-style key, we need to insert in the 'N'. The position of the 'N' is given by the value of the first digit.
if($containsN)
{
	$npos = $digits.IndexOf($productkey[0].ToString())
	$productkey = $productkey.remove(0,1).insert($npos, 'N')
}

#Insert the dashes and return the product key
20,15,10,5 | % {$productkey = $productkey.Insert($_, '-')}
$productkey
