Class constructor($init : Variant)
	This:C1470.content:=""
	If (Count parameters:C259>0)
		Case of 
			: (Value type:C1509($init)=Is text:K8:3)
				This:C1470.content:=$init
				
			: (Value type:C1509($init)=Is object:K8:27)
				If (OB Instance of:C1731($init; 4D:C1709.File))
					This:C1470.content:=$init.getText()
				End if 
		End case 
	End if 
	
Function get($columndel : Text; $linedel : Text)->$col : Collection
	$col:=Null:C1517
	If (Count parameters:C259<1)
		$columndel:=";"
		$linedel:=Char:C90(13)
	Else 
		If (Count parameters:C259<2)
			$linedel:=Char:C90(13)
		End if 
	End if 
	If (This:C1470.content#Null:C1517)
		$lines:=Split string:C1554(This:C1470.content; $linedel)
		If ($lines.length>1)
			$col:=New collection:C1472
			$header:=Split string:C1554($lines[0]; $columndel)
			For ($i; 1; $lines.length-1)
				$cells:=New object:C1471
				$line:=Split string:C1554($lines[$i]; $columndel)
				If ($line.length=$header.length)
					For ($j; 0; $header.length-1)
						$cells[$header[$j]]:=$line[$j]
					End for 
					$col.push($cells)
				End if 
			End for 
		End if 
	End if 
	
Function set($content : Collection; $columndel : Text; $linedel : Text)->$result : Text
	$result:=""
	If (Count parameters:C259<2)
		$columndel:=";"
		$linedel:=Char:C90(13)
	Else 
		If (Count parameters:C259<3)
			$linedel:=Char:C90(13)
		End if 
	End if 
	
	If ($content.length>1)
		$keys:=OB Keys:C1719($content[0])
		$result:=$keys.join($columndel)+$linedel
		For ($i; 0; $content.length-1)
			$values:=OB Values:C1718($content[$i])
			$newline:=$values.join($columndel)
			$result:=$result+$newline+$linedel
		End for 
	End if 