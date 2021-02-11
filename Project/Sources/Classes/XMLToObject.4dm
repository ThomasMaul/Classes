Class constructor($init : Variant; $always_col : Collection)
	Case of 
		: (Value type:C1509($init)=Is text:K8:3)
			This:C1470.content:=$init
			
		: (Value type:C1509($init)=Is object:K8:27)
			If (OB Instance of:C1731($init; 4D:C1709.File))
				This:C1470.content:=$init.getText()
			End if 
	End case 
	If (Count parameters:C259<2)
		This:C1470.always_col:=New collection:C1472
	Else 
		This:C1470.always_col:=$always_col
	End if 
	
Function get($always_col : Collection)->$obj : Object
	If (Count parameters:C259>0)
		This:C1470.always_col:=$always_col
	End if 
	
	var $content; $ref; $subref; $next_XML_Ref; $ElemValue : Text
	var $obj : Object
	
	$content:=This:C1470.content
	$ref:=DOM Parse XML variable:C720($content)
	C_TEXT:C284($name)
	
	If (OK=1)
		$obj:=New object:C1471
		
		// root
		DOM GET XML ELEMENT NAME:C730($ref; $name)
		This:C1470._child($obj; $name; $ref; $ref)
		
		$subref:=DOM Get first child XML element:C723($ref; $Name; $ElemValue)
		This:C1470._child($obj; $name; $subref; $ElemValue)
		
		While (OK=1)
			$next_XML_Ref:=DOM Get next sibling XML element:C724($subref; $Name; $ElemValue)
			$subref:=$next_XML_Ref
			If (OK=1)
				This:C1470._child($obj; $name; $next_XML_Ref; $ElemValue)
			End if 
		End while 
		
		DOM CLOSE XML:C722($ref)
	End if 
	
Function _child($obj : Object; $name : Text; $ref : Text; $value : Text)
	C_OBJECT:C1216($oldobject; $obj; $dummy)
	var $numAttributes; $i; $oldok; $type : Integer
	var $ElemValue; $subref; $testvalue; $child; $next_XML_Ref : Text
	
	$dummy:=New object:C1471
	$numAttributes:=DOM Count XML attributes:C727($ref)
	C_TEXT:C284($Attrib; $ValAttrib)
	For ($i; 1; $numAttributes)
		DOM GET XML ATTRIBUTE BY INDEX:C729($ref; $i; $Attrib; $ValAttrib)
		$dummy[$Attrib]:=$ValAttrib
	End for 
	$testvalue:=Replace string:C233(Replace string:C233($value; "\n"; ""); "\t"; "")
	If ($testvalue#"")
		$dummy.__value:=$value
	End if 
	
	$oldok:=ok
	// check for childs
	$subref:=DOM Get first child XML element:C723($ref; $child; $ElemValue)
	If (OK=1)
		This:C1470._child($dummy; $child; $subref; $ElemValue)
		
		While (OK=1)
			$next_XML_Ref:=DOM Get next sibling XML element:C724($subref; $child; $ElemValue)
			$subref:=$next_XML_Ref
			If (OK=1)
				This:C1470._child($dummy; $child; $next_XML_Ref; $ElemValue)
			End if 
		End while 
	End if 
	ok:=$oldok
	
	// add object to existing main object
	If ($obj[$name]#Null:C1517)  // object already exists, we need a collection
		$type:=Value type:C1509($obj[$name])
		If ($type=Is object:K8:27)
			$oldobject:=$obj[$name]
			$obj[$name]:=New collection:C1472($obj[$name]; $dummy)
		Else 
			$obj[$name].push($dummy)
		End if 
	Else 
		// add it as standard object - except if name is in exception list
		If (This:C1470.always_col.indexOf($name)<0)
			$obj[$name]:=$dummy
		Else 
			// handle it as collection
			$obj[$name]:=New collection:C1472($dummy)
		End if 
	End if 
	