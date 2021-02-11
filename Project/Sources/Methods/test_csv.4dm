//%attributes = {}
// unit test
var $i : Integer
var $csv_text; $result : Text
var $col : Collection
var $csv : cs:C1710.csv

For ($i; 1; 3)
	Case of 
		: ($i=1)
			$csv_text:="A1;A2;A3"+Char:C90(13)+Char:C90(10)+"1;2;3"+Char:C90(13)+Char:C90(10)+"4;5;6"
			$csv:=cs:C1710.csv.new($csv_text)
			$col:=$csv.get()
			
		: ($i=2)
			$csv_text:="A1\tA2\tA3"+Char:C90(13)+Char:C90(10)+"1\t2\t3"+Char:C90(13)+Char:C90(10)+"4\t5\t6"
			$csv:=cs:C1710.csv.new($csv_text)
			$col:=$csv.get(Char:C90(9))
			
		: ($i=3)
			$csv_text:="A1\tA2\tA3"+Char:C90(13)+"1\t2\t3"+Char:C90(13)+Char:C90(10)+"4\t5\t6"
			$csv:=cs:C1710.csv.new($csv_text)
			$col:=$csv.get(Char:C90(9); Char:C90(13))
	End case 
	
	
	
	ASSERT:C1129($col.length=2; "Wrong number of lines")
	ASSERT:C1129($col[0].A2="2"; "Wrong content first line 2nd column")
	ASSERT:C1129($col[1].A3="6"; "Wrong content first line 2nd column")
End for 


$col:=New collection:C1472(New object:C1471("C1"; "A1"; "C2"; "A2"; "C3"; "A3"); New object:C1471("C1"; "A4"; "C2"; "A5"; "C3"; "A6"))
$csv:=cs:C1710.csv.new("")
$result:=$csv.set($col; ";"; Char:C90(13))
$csv_text:="C1;C2;C3"+Char:C90(13)+"A1;A2;A3"+Char:C90(13)+"A4;A5;A6"+Char:C90(13)
ASSERT:C1129($result=$csv_text; "cvs set failure")


If (Get call chain:C1662.length=1)  // direct call, not via global test
	ALERT:C41("Done")
End if 