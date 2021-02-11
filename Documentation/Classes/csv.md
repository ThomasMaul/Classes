<!-- makes reading/importing csv easy  -->
## Description

makes reading/importing csv easy  
Pass either a file object for the csv or the content as text  
Better to pass file object, as this handles line delimiter (cr/lf/crlf) automatically  
In case you need to pass text, you need to set the line delimiter yourself.
Receive content as collection, allowing to code such as:

```4D
$ref:=Open document(""; ".csv"; Get pathname)
If (OK=1)
	$file:=File(document; fk platform path)
	$csv:=cs.csv.new($file)
	$data:=$csv.get()

	For each ($line; $data)
		If ($line["Status"]="ok")
			$ISIN:=$line["ISIN"]
			$Name:=$line["Name"]
```

## init   cs.csv.new(File/Text)
Initialize a new instance.  
Pass the text (content) of the csv or a file object.  
csv must be tab tab return formated

## get() -> collection
returns content of csv as collection

## set($content : Collection; $columndel : Text; $linedel : Text) -> $result : Text
Creates a new csv, returned as text  
Pass a collection, and optionally column/line delimiter (default ; and R)  

```4D
$col:=New collection(New object("C1"; "A1"; "C2"; "A2"; "C3"; "A3"); New object("C1"; "A4"; "C2"; "A5"; "C3"; "A6"))
$csv:=cs.csv.new("")
$result:=$csv.set($col; ";"; Char(13))
```
