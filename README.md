The Windows product key is a 25 digit code, comprised of an alphabet of 24 characters (BCDFGHJKMPQRTVWXY2346789). When treated as an integer, this product key forms a base-24 number with 25 digits. Stored in binary, this number takes up 115 bits [log2(24^25) =~ 114.6]. This integer is stored in bytes 52 through 66 of registry binary value HKLM:\Software\Microsoft\Windows NT\CurrentVersion\DigitalProductId, encoded little-endian. To retrieve the human-transcribable product key, the binary is converted back to a base-24 number using the product key alphabet.

Starting with Windows 8, product keys can now contain a single 'N'. Even though technically the alphabet has expanded to 25 characters, the underlying encoding and alphabet has not changed. Instead, the 116th bit of the sequence is now a flag to determine if this is a new-style key that contains an 'N', and the product key is altered to use the same legacy encoding technique. The position of the 'N' determines the value of the first digit - the 'N' is removed from the product key, and the product key is prepended by the alphabet character that corresponds to the position the 'N' was removed from.

For example, given a product key of "BBBBB-CCCCC-DDDDD-NFFFF-GGGGG", the 'N' is in the 16th position. The 'N' is removed, and the 16th character of the alphabet is inserted into the front of the key. The resulting product key would be "XBBBB-BCCCC-CDDDD-DFFFF-GGGGG"
