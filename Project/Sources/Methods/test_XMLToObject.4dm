//%attributes = {}
// unit test


For ($i; 1; 1)
	Case of 
		: ($i=1)
			$cvs_text:="<gen9><RootElement>\n      <Elem1>\n         <Elem2>\n            <Elem3 Font=\"Verdana\" Size=\"10\"> </Elem3>\n         </Elem2>\n      </Elem1>\n   </RootElement></gen9>"
			$csv:=cs:C1710.XMLToObject.new($cvs_text)
			$obj:=$csv.get()
			
	End case 
	
	
	ASSERT:C1129(String:C10($obj.RootElement.Elem1.Elem2.Elem3.Font)="Verdana"; "XML converting failed")
	
End for 




If (Get call chain:C1662.length=1)  // direct call, not via global test
	ALERT:C41("Done")
End if 