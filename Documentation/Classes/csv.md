### CSV Class Documentation

#### Class Constructor

```4d
Class constructor($init : Variant)
```

**Description:**
Initializes a new instance of the CSV class.

**Parameters:**
- `$init` (Variant): Optional. Can be a text or a 4D File object. If provided, it initializes the content of the CSV class.

**Usage:**
- If `$init` is a text, it sets the content of the CSV class to the provided text.
- If `$init` is a 4D File object, it reads the text content from the file and sets it as the content of the CSV class. This handles line delimiter (cr/lf/crlf) automatically  

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

---

#### Function: `get`

```4d
Function get($columndelpara : Text; $linedelpara : Text)->$col : Collection
```

**Description:**
Parses the CSV content and returns it as a collection of objects.

**Parameters:**
- `$columndelpara` (Text): Optional. The column delimiter. Default is `";"`.
- `$linedelpara` (Text): Optional. The line delimiter. Default is `Char(13)` (carriage return).

**Returns:**
- `$col` (Collection): A collection of objects where each object represents a row in the CSV. The keys of the objects are the column headers.

**Usage:**
- If no parameters are provided, it uses `";"` as the column delimiter and `Char(13)` as the line delimiter.
- If only one parameter is provided, it uses the provided column delimiter and `Char(13)` as the line delimiter.
- If both parameters are provided, it uses them as the column and line delimiters respectively.

---

#### Function: `set`

```4d
Function set($content : Collection; $columndelpara : Text; $linedelpara : Text)->$result : Text
```

**Description:**
Converts a collection of objects into a CSV formatted text.

**Parameters:**
- `$content` (Collection): A collection of objects to be converted into CSV format.
- `$columndelpara` (Text): Optional. The column delimiter. Default is `";"`.
- `$linedelpara` (Text): Optional. The line delimiter. Default is `Char(13)` (carriage return).

**Returns:**
- `$result` (Text): The CSV formatted text.

**Usage:**
- If no parameters are provided, it uses `";"` as the column delimiter and `Char(13)` as the line delimiter.
- If only one parameter is provided, it uses the provided column delimiter and `Char(13)` as the line delimiter.
- If both parameters are provided, it uses them as the column and line delimiters respectively.
- The first row of the CSV will contain the keys of the objects as the column headers. Each subsequent row will contain the values of the objects.

---

This documentation provides an overview of the CSV class and its functions, detailing their purpose, parameters, return values, and usage.