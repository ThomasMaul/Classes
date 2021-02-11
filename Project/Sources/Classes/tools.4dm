Class constructor
	
	// generic
Function HexToDec($hex : Text)->$dec : Integer
	// hex as "A2b3"
	
	C_TEXT:C284($thisPosition)
	C_LONGINT:C283($thisMultiplier; $length; $a)
	$dec:=0
	$length:=Length:C16($hex)
	For ($a; 1; $length)
		$thisPosition:=Substring:C12($hex; $a; 1)
		Case of 
			: ($thisPosition="A")
				$thisPosition:="10"
			: ($thisPosition="B")
				$thisPosition:="11"
			: ($thisPosition="C")
				$thisPosition:="12"
			: ($thisPosition="D")
				$thisPosition:="13"
			: ($thisPosition="E")
				$thisPosition:="14"
			: ($thisPosition="F")
				$thisPosition:="15"
		End case 
		$thisMultiplier:=16^($length-$a)
		$dec:=$dec+(Num:C11($thisPosition)*($thisMultiplier))
	End for 
	
Function CalendarWeek($date : Date)->$week : Integer
/*
return calenderweek based on DIN 1355 (ISO/R 2015-1971) / ISO 8601
from Ortwin Zillgen
Note: for Europeans, not for USA...
*/
	
	C_DATE:C307($dat_jan4; $dat_dez31; $dat_jan1_vj)
	$dat_jan4:=Add to date:C393(!1900-01-04!; (Year of:C25($date)-1900); 0; 0)
	$week:=(($date+7)-($dat_jan4-((Day number:C114($dat_jan4)+5)%7)))\7
	Case of 
		: ($week=0)
			$dat_jan1_vj:=Add to date:C393(!1900-01-01!; (Year of:C25($date)-1901); 0; 0)
			If ((Day number:C114($dat_jan1_vj)=5) | (Day number:C114($dat_jan4-4)=5))
				$week:=53
			Else 
				$week:=52
			End if 
		: ($week=53)
			$dat_dez31:=Add to date:C393(!1900-12-31!; (Year of:C25($date)-1900); 0; 0)
			If ((Day number:C114($dat_jan4-3)#5) & (Day number:C114($dat_dez31)#5))
				$week:=1
			End if 
	End case 
	
Function ResizeArray($array : Pointer; $newsize : Integer)
	// allows resizing for arrays of any type
	
	var $alt; $a; $pos : Integer
	
	ASSERT:C1129($newsize>=0; "Size needs to be >=0")
	ASSERT:C1129(Type:C295($array)=Is pointer:K8:14; "parameter 1 needs to be a pointer to an array")
	$a:=Type:C295($array->)
	ASSERT:C1129(($a=Boolean array:K8:21) | ($a=Date array:K8:20) | ($a=Integer array:K8:18) | ($a=LongInt array:K8:19) | ($a=Picture array:K8:22)\
		 | ($a=Pointer array:K8:23) | ($a=Real array:K8:17) | ($a=String array:K8:15) | ($a=Text array:K8:16) | ($a=31) | ($a=32) | ($a=39); \
		"Parameter 1 needs to be pointer to array, received type="+String:C10($a))
	
	$alt:=Size of array:C274($array->)
	Case of 
		: ($newsize>$alt)
			$pos:=$newsize-$alt
			INSERT IN ARRAY:C227($array->; $alt+1; $pos)
		: ($newsize<$alt)
			$pos:=$alt-$newsize
			DELETE FROM ARRAY:C228($array->; $alt-$pos+1; $pos)
	End case 
	
	
	// GUI
Function AdjustWindowSize($formname : Text; $curFormTable : Pointer)
/*
checks if current window is fully visible and large enough for current form
*/
	
	ASSERT:C1129($formname#""; "Form name required as parameter 1")
	ASSERT:C1129(Type:C295($curFormTable)=Is pointer:K8:14; "Pointer required as parameter 2")
	
	var $links2; $oben2; $rechts2; $unten2; $pos; $breite; $höhe : Integer
	
	$pos:=Position:C15("]."; $formname)
	$formname:=Substring:C12($formname; $pos+2)
	
	GET WINDOW RECT:C443($links2; $oben2; $rechts2; $unten2)
	FORM GET PROPERTIES:C674($curFormTable->; $formname; $breite; $höhe)
	If (($rechts2-$links2)<$breite)
		$rechts2:=$links2+$breite
		If ($rechts2>(Screen width:C187-10))
			$rechts2:=Screen width:C187-10
			$links2:=$rechts2-$breite
		End if 
		SET WINDOW RECT:C444($links2; $oben2; $rechts2; $unten2)
	End if 
	If (($unten2-$oben2)<$höhe)
		$unten2:=$oben2+$höhe
		If ($unten2>(Screen height:C188-10))
			$unten2:=Screen height:C188-10
			$oben2:=$unten2-$oben2
		End if 
		SET WINDOW RECT:C444($links2; $oben2; $rechts2; $unten2)
	End if 
	
Function OpenFormWindowStack($formular : Text; $parawindowtyp : Integer; $tablePtr : Pointer)->$win : Integer
	// open form window with stack feature
	// parameter : form name, then window type, then table ptr (if table form)
	
	var $left_Master; $top_Master; $right_Master; $bottom_Master; $windowtyp : Integer
	
	GET WINDOW RECT:C443($left_Master; $top_Master; $right_Master; $bottom_Master; Frontmost window:C447)
	
	If (Count parameters:C259=1)
		$windowtyp:=Plain window:K34:13
	Else 
		$windowtyp:=$parawindowtyp
	End if 
	
	If (Count parameters:C259<3)
		$win:=Open form window:C675($formular; $windowtyp; $left_Master+20; $top_Master+20)
	Else 
		$win:=Open form window:C675($tablePtr->; $formular; $windowtyp; $left_Master+20; $top_Master+20)
	End if 
	
Function GetWindowSizeInObject->$obj : Object
	var $left; $top; $right; $bottom : Integer
	GET WINDOW RECT:C443($left; $top; $right; $bottom)
	$obj:=New object:C1471("left"; $left; "top"; $top; "right"; $right; "bottom"; $bottom)
	
Function SetWindowSizeFromObject($obj : Object)
	// modify window size, based on Object $1
	// if object empty, nothing is done
	var $left; $top; $right; $bottom : Integer
	If (Not:C34(OB Is empty:C1297($obj)))
		$left:=Num:C11($obj.left)
		$top:=Num:C11($obj.top)
		$right:=Num:C11($obj.right)
		$bottom:=Num:C11($obj.bottom)
		SET WINDOW RECT:C444($left; $top; $right; $bottom)
	End if 
	
	
	// check specific
Function CheckIBAN($IBAN : Text)->$correct : Boolean
/*
## Tools_CheckIBAN(String IBAN)=Boolean
check IBAN number if valid (true/false)
*/
	
	var $iban1; $pz; $part : Text
	var $rest; $pos : Integer
	
	$correct:=False:C215
	$IBAN:=Replace string:C233($1; " "; "")
	
	If (Length:C16($IBAN)<16)
		$correct:=False:C215
	Else 
		$iban1:=Substring:C12($IBAN; 5)+\
			String:C10(Character code:C91($IBAN[[1]])-55)+\
			String:C10(Character code:C91($IBAN[[2]])-55)+Substring:C12($IBAN; 3; 2)
		
		$rest:=0
		For ($pos; 1; Length:C16($iban1); 7)
			$part:=String:C10($rest)+Substring:C12($iban1; $pos; 7)
			$rest:=Num:C11($part)%97
		End for 
		$pz:=String:C10(98-$rest)
		If ($rest=1)
			$correct:=True:C214
		Else 
			$correct:=False:C215
		End if 
	End if 
	
Function CheckEmailAddress($emailAddress : Text)->$result : Boolean
	$result:=False:C215
	//C_TEXT($user_email_username; $user_email_domain)
	C_TEXT:C284($pattern)
	
	$pattern:="^([-a-zA-Z0-9_]+(?:\\.[-a-zA-Z0-9_]+)*)(?:@)([-a-zA-Z0-9\\._]+(?:\\.[a-zA-Z0-9]{2,4})+)$"  // Olivier
	//  $Pattern:="^([^@\\s]+)@((?:[-a-z0-9]{1,63}+\\.)+[a-z]{2,4})$"  ` Maurice
	ARRAY LONGINT:C221($_position; 0)
	ARRAY LONGINT:C221($_length; 0)
	If (Match regex:C1019($pattern; $emailAddress; 1; $_position; $_length))
		If ($_length{0}=Length:C16($emailAddress))
			//$email_username:=Substring($emailAddress; $_position{1}; $_length{1})  // optional, if you need that, not used here...
			//$email_domain:=Substring($emailAddress; $_position{2}; $_length{2})
			$result:=True:C214
		End if 
	End if 
	
	
	// Filter text
Function Filter_OnlyNumeric($text : Text; $special : Boolean)->$result : Text
	// allows only numeric chars, if special=true also -., (system specific decimal and thousand separators)
	var $numeric; $char : Text
	var $i : Integer
	$numeric:="0123456789"
	If (Count parameters:C259>1)
		If ($special)
			$numeric:=$numeric+"-"
			GET SYSTEM FORMAT:C994(Decimal separator:K60:1; $char)
			$numeric:=$numeric+$char
			GET SYSTEM FORMAT:C994(Thousand separator:K60:2; $char)
			$numeric:=$numeric+$char
		End if 
	End if 
	$result:=""
	For ($i; 1; Length:C16($text))
		If (Position:C15($text[[$i]]; $numeric)>0)
			$result:=$result+$text[[$i]]
		End if 
	End for 
	
Function Filter_RemoveWildcard($text : Text)->$result : Text
	var $i : Integer
	$result:=""
	For ($i; 1; Length:C16($text))
		If (Character code:C91($text[[$i]])#64)
			$result:=$result+$text[[$i]]
		End if 
	End for 
	
Function Filter_RemoveLeadingEndingBlanks($text : Text)->$result : Text
	While ($text=" @")
		$text:=Substring:C12($text; 2)
	End while 
	While ($text="@ ")
		$text:=Substring:C12($text; 1; Length:C16($text)-1)
	End while 
	$result:=$text
	
Function Filter_RemoveLeadingZero($text : Text)->$result : Text
	While ($text="0@")
		$text:=Substring:C12($text; 2)
	End while 
	$result:=$text
	
Function Filter_RemoveTabReturn($text : Text)->$result : Text
	var $i; $charcode : Integer
	
	$result:=""
	For ($i; 1; Length:C16($text))
		$charcode:=Character code:C91($text[[$i]])
		If (($charcode#9) & ($charcode#13) & ($charcode#10))
			$result:=$result+$text[[$i]]
		End if 
	End for 
	
Function FindNextNewLine($text : Text; $start : Integer)->$resultpos : Integer
	// Find next new line
	// in case we don't know if it is 10, 13 or 13/10
	var $pos : Integer
	
	If (Count parameters:C259>1)
		$pos:=$start
	Else 
		$pos:=1
	End if 
	
	If ($text#"")
		While (($pos<Length:C16($text)) & ($text[[$pos]]#Char:C90(13)) & ($text[[$pos]]#Char:C90(10)))
			$pos:=$pos+1
		End while 
		$resultpos:=$pos
	Else 
		$resultpos:=0
	End if 
	
Function KoelnerPhonetik($word : Text)->$soundex : Text
	var $result; $word; $zwischen; $char; $last : Text
	var $charvalue; $loopstart; $x; $i : Integer
	
	$result:=""
	
	$word:=Uppercase:C13($word)
	$word:=Replace string:C233($word; "v"; "F")
	$word:=Replace string:C233($word; "w"; "F")
	$word:=Replace string:C233($word; "j"; "I")
	$word:=Replace string:C233($word; "ph"; "F")
	
	If (Length:C16($word)>0)
		
		// Nur Buchstaben(keine Zahlen, keine Sonderzeichen)
		$zwischen:=""
		For ($i; 1; Length:C16($word))
			$charvalue:=Character code:C91($word[[$i]])
			If (($charvalue>64) & ($charvalue<91))
				$zwischen:=$zwischen+$word[[$i]]
			End if 
		End for 
		$word:=$zwischen
		
		$loopstart:=0
		If (Length:C16($word)>0)
			// Sonderfälle bei Wortanfang(Anlaut)
			If ($word[[1]]="c")
				If (Length:C16($word)=1)
					$result:="8"
					$loopstart:=1
				Else 
					If (Position:C15($word[[2]]; "ahkloqrux")>0)
						$result:="4"
					Else 
						$result:="8"
					End if 
					$loopstart:=1
				End if 
			End if 
			
			// end Anlaut
			
			For ($x; $loopstart+1; Length:C16($word))
				$char:=$word[[$x]]
				Case of 
					: (Position:C15($char; "aeiou")>0)
						$result:=$result+"0"
					: (Position:C15($char; "bp")>0)
						$result:=$result+"1"
					: (Position:C15($char; "dt")>0)
						If ($x<Length:C16($word))
							If (Position:C15($word[[$x+1]]; "csz")>0)
								$result:=$result+"8"
							Else 
								$result:=$result+"2"
							End if 
						Else 
							$result:=$result+"2"
						End if 
					: ($char="f")
						$result:=$result+"3"
					: (Position:C15($char; "qkg")>0)
						$result:=$result+"4"
					: ($char="c")
						If ($x<Length:C16($word))
							If (Position:C15($word[[$x+1]]; "ahkoqux")>0)
								// nun davor
								If (Position:C15($word[[$x-1]]; "sz")>0)
									$result:=$result+"8"
								Else 
									$result:=$result+"4"
								End if 
							Else 
								$result:=$result+"8"
							End if 
						Else 
							$result:=$result+"8"
						End if 
					: ($char="x")
						If ($x>1)
							If (Position:C15($word[[$x-1]]; "ckq")>0)
								$result:=$result+"8"
							Else 
								$result:=$result+"48"
							End if 
						Else 
							$result:=$result+"48"
						End if 
					: ($char="l")
						$result:=$result+"5"
					: (Position:C15($char; "mn")>0)
						$result:=$result+"6"
					: ($char="r")
						$result:=$result+"7"
					: (Position:C15($char; "sz")>0)
						$result:=$result+"8"
				End case 
			End for 
			
		End if   // size#0
		
		
	End if   // size#0
	
	If ($result#"")
		$result:=$result[[1]]+Replace string:C233(Substring:C12($result; 2); "0"; "")
	End if 
	
	// Mehrfach Codes entfernen
	$last:=""
	$x:=1
	$zwischen:=""
	For ($x; 1; Length:C16($result))
		$char:=$result[[$x]]
		If ($char#$last)
			$zwischen:=$zwischen+$char
			$last:=$char
		End if 
	End for 
	$soundex:=$zwischen
	
Function Soundex($word : Text; $strength : Integer)->$soundex : Text
	//  Tech Note 6/92
	
	If ($word#"")
		C_TEXT:C284($SoundsI; $Sounds)
		C_LONGINT:C283($Zähler; $Nummer; $i; $Genau)
		
		$Sounds:="aehiouwybfpvcgjkqsxzdtlmnr"  //Group characters that sound alike
		$SoundsI:="11111111222233333333445667"  //Assign numbers for each group
		
		If (Count parameters:C259>=2)
			$Genau:=$strength
		Else 
			$Genau:=3
		End if 
		
		$soundex:=$word[[1]]+("0"*$Genau)  //Set a phonetic equivalent default
		$Zähler:=2
		$Nummer:=0
		For ($i; 2; Length:C16($word)-1)
			$Nummer:=Position:C15($word[[$i]]; $Sounds)
			If ($Nummer>0)
				If (($Zähler=2) | (($Zähler>2) & (Character code:C91($SoundsI[[$Nummer]])#Character code:C91($soundex[[$Zähler-1]]))))
					$soundex[[$Zähler]]:=$SoundsI[[$Nummer]]-1
					$Zähler:=$Zähler+1
					If ($Zähler>($Genau+1))
						$i:=Length:C16($word)
					End if 
				End if 
			End if 
		End for 
	Else 
		$soundex:=""
	End if 
	
	
	
	// Web Helper
Function AccessWebVariables($body : Boolean)->$variables : Object
	// return web variables as object for fast access
	// if optional $body is true, it checks if body contains json (for HTTP POST) and includes that in object as well
	
	ARRAY TEXT:C222($anames; 0)
	ARRAY TEXT:C222($avalues; 0)
	WEB GET VARIABLES:C683($anames; $avalues)
	$variables:=New object:C1471
	
	var $i; $old : Integer
	var $requestText; $key : Text
	var $json : Object
	var $keys : Collection
	
	For ($i; 1; Size of array:C274($anames))
		$variables[$anames{$i}]:=$avalues{$i}
	End for 
	If (Count parameters:C259>0)
		If ($body)
			WEB GET HTTP BODY:C814($requestText)
			If ($requestText="{@}")
				$old:=Get database parameter:C643(Dates inside objects:K37:73)
				SET DATABASE PARAMETER:C642(Dates inside objects:K37:73; String type with time zone:K37:87)
				$json:=JSON Parse:C1218($requestText)
				SET DATABASE PARAMETER:C642(Dates inside objects:K37:73; $old)
				If ($json#Null:C1517)
					$keys:=OB Keys:C1719($json)
					For each ($key; $keys)
						If ($variables[$key]=Null:C1517)
							$variables[$key]:=$json[$key]
						End if 
					End for each 
				End if 
			End if 
		End if 
	End if 
	
Function AccessWebHeader->$variables : Object
	// return web header as object for fast access
	
	ARRAY TEXT:C222($anames; 0)
	ARRAY TEXT:C222($avalues; 0)
	WEB GET HTTP HEADER:C697($anames; $avalues)
	$variables:=New object:C1471
	
	var $i : Integer
	
	For ($i; 1; Size of array:C274($anames))
		$variables[$anames{$i}]:=$avalues{$i}
	End for 
	
Function URLEncoder($url : Text; $encoding : Text)->$result : Text
	//  useful if you need to encode your URL
	// example:  "www.test.com/my method"  contains a blank, so needs to be converted to "www.test.com/my%20method"
	// $format could be UTF-8 or ISO-8859-1
	// characters > 127 will be encoded using this format. 
	//  encodes umlauts, blanks and other special chars in an URL
	
	var $format; $WSPI_MyChar; $out : Text
	var $blob : Blob
	var $WSPI_parser; $charIn; $WSPI_ascii; $i; $WSPI_n : Integer
	
	$result:=""
	If (Count parameters:C259>1)
		$format:=$encoding
	Else 
		$format:="ISO-8859-1"
	End if 
	
	// If the charset is different than Latin-1 please add your translation below
	// Parse the string and translate the special characters
	For ($WSPI_parser; 1; Length:C16($url))
		$WSPI_MyChar:=Substring:C12($url; $WSPI_parser; 1)
		$WSPI_ascii:=Character code:C91($WSPI_MyChar)
		If ((($WSPI_ascii>=Character code:C91("a'")) & ($WSPI_ascii<=Character code:C91("z'"))) | (($WSPI_ascii>=Character code:C91("A")) & ($WSPI_ascii<=Character code:C91("Z"))) | (($WSPI_ascii>=Character code:C91("0")) & ($WSPI_ascii<=Character code:C91("9"))) | ($WSPI_MyChar="*") | ($WSPI_MyChar="-") | ($WSPI_MyChar=".") | ($WSPI_MyChar="_") | ($WSPI_MyChar="/"))
			$result:=$result+$WSPI_MyChar
		Else 
			SET BLOB SIZE:C606($blob; 0)
			CONVERT FROM TEXT:C1011($WSPI_MyChar; $format; $blob)
			For ($i; 1; BLOB size:C605($blob))
				$charIn:=$blob{$i-1}
				$out:="%"
				$WSPI_n:=$charIn\16
				If ($WSPI_n<10)
					$out:=$out+String:C10($WSPI_n)
				Else 
					$out:=$out+Char:C90(Character code:C91("A")+$WSPI_n-10)
				End if 
				$WSPI_n:=$charIn%16
				If ($WSPI_n<10)
					$out:=$out+String:C10($WSPI_n)
				Else 
					$out:=$out+Char:C90(Character code:C91("A")+$WSPI_n-10)
				End if 
				$result:=$result+$out
			End for 
		End if 
	End for 
	
	
	// ODRA helper
Function ORDA_GetRelationSelection($fromSelection : Object; $TargetClassName : Text; $MaxDepth : Integer)->$relatedSelection : Object
	// join an entity selection to a related data class and return selection
	// useful if you have a selection and know where you want to go, but not the name of the relation or the path
	
	ASSERT:C1129($fromSelection.getDataClass()#Null:C1517; "$1 must be an entity selection or entity")
	ASSERT:C1129($TargetClassName#""; "$2 must not be empty")
	ASSERT:C1129(ds:C1482[$TargetClassName]#Null:C1517; "$2 must be the name of a data class")
	ASSERT:C1129(($MaxDepth>=0) & ($MaxDepth<10); "$3 must be in range 0..9")
	
	C_TEXT:C284($fromName; $path)
	C_OBJECT:C1216($o; $result)
	$fromName:=$fromSelection.getDataClass().getInfo().name
	
	$path:=This:C1470._ORDA_FindRelationPath($fromName; $TargetClassName; $MaxDepth)
	If ($path#"")
		$o:=New object:C1471("from"; $fromSelection; "to"; New object:C1471())
		$o.formula:=Formula from string:C1601("This.to:=This.from"+$path)
		$o.formula()  //$o.to contains result!
		$result:=$o.to
	End if 
	
	If ($result=Null:C1517)
		$relatedSelection:=ds:C1482[$TargetClassName].newSelection()
	Else 
		$relatedSelection:=$result
	End if 
	
Function ORDA_GetFieldTypeFromPath($path : Text)->$fieldtyp : Integer
	// returns field type for a given path
	// like Customer.name or Invoice.Customer.Name or InvoiceItem.Invoice.Customer.Name
	
	C_COLLECTION:C1488($parts; $col)
	C_OBJECT:C1216($type; $table)
	var $tablename; $newpath : Text
	
	$parts:=Split string:C1554($path; "."; sk trim spaces:K86:2+sk ignore empty strings:K86:1)
	ASSERT:C1129($parts.length>=2; "Path needs to be minimum class and attribute")
	
	If ($parts.length=2)  // we have the direct field
		$type:=ds:C1482[$parts[0]][$parts[1]]
		$fieldtyp:=$type.fieldType
	Else 
		// first part is table name, second relation name, more to follow
		// find related table name
		$table:=ds:C1482[$parts[0]][$parts[1]]
		$tablename:=String:C10($table.relatedDataClass)
		
		$col:=$parts.remove(0; 2)
		$newpath:=$tablename+"."+$col.join(".")
		$fieldtyp:=This:C1470.ORDA_GetFieldTypeFromPath($newpath)
	End if 
	
	
	
	
	// ******  INTERNAL ONLY  ********
	
Function _ORDA_FindRelationPath($FromClassName : Text; $ToClassName : Text; $MaxDepth : Integer)->$pathout : Text
	// find path between two classes
	// $1 = classFrom, $2 = classTo, $3 = maxdepth
	// $0 := path
	// not public
	
	C_OBJECT:C1216($field)
	C_TEXT:C284($name)
	$pathout:=""
	
	ASSERT:C1129($FromClassName#""; "$1 must not be empty")
	ASSERT:C1129($ToClassName#""; "$2 must not be empty")
	ASSERT:C1129(($MaxDepth>=0) & ($MaxDepth<10); "$3 must be in range 0..9")
	ASSERT:C1129(ds:C1482[$FromClassName]#Null:C1517; "$1 must be the name of a data class")
	ASSERT:C1129(ds:C1482[$ToClassName]#Null:C1517; "$1 must be the name of a data class")
	
	For each ($name; ds:C1482[$FromClassName]) Until ($pathout#"")
		$field:=ds:C1482[$FromClassName][$name]
		If (($field.kind="relatedEntity") | ($field.kind="relatedEntities"))
			If ($field.relatedDataClass=$ToClassName)  // hit
				$pathout:="."+$field.name
			End if 
		End if 
	End for each 
	
	// if no, for all properties of kind = relatedEntity or relatedEntities run recursive to find To
	If ($pathout="")  // not found
		If ($MaxDepth>0)
			For each ($name; ds:C1482[$FromClassName]) While ($pathout="")
				$field:=ds:C1482[$FromClassName][$name]
				If (($field.kind="relatedEntity") | ($field.kind="relatedEntities"))
					$pathout:=This:C1470._ORDA_FindRelationPath($field.relatedDataClass; $ToClassName; $MaxDepth-1)
					If ($pathout#"")
						$pathout:="."+$field.name+$pathout
					End if 
				End if 
			End for each 
		End if 
	End if 
	
	