# Tools Class Documentation

## Class Constructor

```4d
singleton Class constructor
```

**Description:**
Initializes a singleton instance of the Tools class.

---

## Generic Functions

### Function: `HexToDec`

```4d
Function HexToDec($hex : Text)->$dec : Integer
```

**Description:**
Converts a hexadecimal string to a decimal integer.

**Parameters:**
- `$hex` (Text): The hexadecimal string to convert. Example: "A2b3".

**Returns:**
- `$dec` (Integer): The decimal representation of the hexadecimal string.

---

### Function: `CalendarWeek`

```4d
Function CalendarWeek($date : Date)->$week : Integer
```

**Description:**
Returns the calendar week based on DIN 1355 (ISO/R 2015-1971) / ISO 8601.

**Parameters:**
- `$date` (Date): The date for which to calculate the calendar week.

**Returns:**
- `$week` (Integer): The calendar week number.

---

### Function: `ResizeArray`

```4d
Function ResizeArray($array : Pointer; $newsize : Integer)
```

**Description:**
Resizes an array to the specified new size.

**Parameters:**
- `$array` (Pointer): A pointer to the array to resize.
- `$newsize` (Integer): The new size of the array.

---

### Function: `flattenCollection`

```4d
Function flattenCollection($col : Collection; $fullName : Boolean)
```

**Description:**
Flattens a collection of objects, optionally using full names for nested objects.

**Parameters:**
- `$col` (Collection): The collection to flatten.
- `$fullName` (Boolean): If true, uses full names for nested objects.

---

## GUI Functions

### Function: `AdjustWindowSize`

```4d
Function AdjustWindowSize($formname : Text; $curFormTable : Pointer)
```

**Description:**
Checks if the current window is fully visible and large enough for the given form.

**Parameters:**
- `$formname` (Text): The name of the form.
- `$curFormTable` (Pointer): A pointer to the form table.

---

### Function: `OpenFormWindowStack`

```4d
Function OpenFormWindowStack($formular : Text; $parawindowtyp : Integer; $tablePtr : Pointer)->$win : Integer
```

**Description:**
Opens a window stacked above the current one.

**Parameters:**
- `$formular` (Text): The name of the form.
- `$parawindowtyp` (Integer): The type of the window.
- `$tablePtr` (Pointer): A pointer to the table (if applicable).

**Returns:**
- `$win` (Integer): The window reference number.

---

### Function: `GetWindowSizeInObject`

```4d
Function GetWindowSizeInObject->$obj : Object
```

**Description:**
Reads the current window position and stores left/top/right/bottom in an object.

**Returns:**
- `$obj` (Object): An object containing the window position.

---

### Function: `SetWindowSizeFromObject`

```4d
Function SetWindowSizeFromObject($obj : Object)
```

**Description:**
Restores the current window position from an object created using `GetWindowSizeInObject`.

**Parameters:**
- `$obj` (Object): The object containing the window position.

---

## Check Specific Functions

### Function: `CheckIBAN`

```4d
Function CheckIBAN($IBAN : Text)->$correct : Boolean
```

**Description:**
Checks if an IBAN number is valid.

**Parameters:**
- `$IBAN` (Text): The IBAN number to check.

**Returns:**
- `$correct` (Boolean): True if the IBAN is valid, false otherwise.

---

### Function: `CheckEmailAddress`

```4d
Function CheckEmailAddress($emailAddress : Text)->$result : Boolean
```

**Description:**
Checks if an email address is valid.

**Parameters:**
- `$emailAddress` (Text): The email address to check.

**Returns:**
- `$result` (Boolean): True if the email address is valid, false otherwise.

---

## Filter Text Functions

### Function: `Filter_OnlyNumeric`

```4d
Function Filter_OnlyNumeric($text : Text; $special : Boolean)->$result : Text
```

**Description:**
Allows only numeric characters in the text. If `$special` is true, also allows `-`, `.`, and system-specific decimal and thousand separators.

**Parameters:**
- `$text` (Text): The text to filter.
- `$special` (Boolean): If true, allows special characters.

**Returns:**
- `$result` (Text): The filtered text.

---

### Function: `Filter_RemoveWildcard`

```4d
Function Filter_RemoveWildcard($text : Text)->$result : Text
```

**Description:**
Removes `@` from the string.

**Parameters:**
- `$text` (Text): The text to filter.

**Returns:**
- `$result` (Text): The filtered text.

---

### Function: `Filter_RemoveLeadingEndingBlanks`

```4d
Function Filter_RemoveLeadingEndingBlanks($text : Text)->$result : Text
```

**Description:**
Removes leading or ending blanks (char 34) from the string.

**Parameters:**
- `$text` (Text): The text to filter.

**Returns:**
- `$result` (Text): The filtered text.

---

### Function: `Filter_RemoveLeadingZero`

```4d
Function Filter_RemoveLeadingZero($text : Text)->$result : Text
```

**Description:**
Removes leading zeros from the string.

**Parameters:**
- `$text` (Text): The text to filter.

**Returns:**
- `$result` (Text): The filtered text.

---

### Function: `Filter_RemoveTabReturn`

```4d
Function Filter_RemoveTabReturn($text : Text)->$result : Text
```

**Description:**
Removes char 9, 10, or 13 from the string.

**Parameters:**
- `$text` (Text): The text to filter.

**Returns:**
- `$result` (Text): The filtered text.

---

### Function: `FindNextNewLine`

```4d
Function FindNextNewLine($text : Text; $start : Integer)->$resultpos : Integer
```

**Description:**
Returns the position of the next new line character, useful if it could be 10, 13, or 13/10.

**Parameters:**
- `$text` (Text): The text to search.
- `$start` (Integer): Optional. The starting position for the search.

**Returns:**
- `$resultpos` (Integer): The position of the next new line character.

---

### Function: `KoelnerPhonetik`

```4d
Function KoelnerPhonetik($word : Text)->$soundex : Text
```

**Description:**
Generates the Kölner Phonetik (Cologne Phonetics) code for a given word.

**Parameters:**
- `$word` (Text): The word to encode.

**Returns:**
- `$soundex` (Text): The Kölner Phonetik code.

---

### Function: `Soundex`

```4d
Function Soundex($word : Text; $strength : Integer)->$soundex : Text
```

**Description:**
Generates the Soundex code for a given word.

**Parameters:**
- `$word` (Text): The word to encode.
- `$strength` (Integer): The strength of the encoding.

**Returns:**
- `$soundex` (Text): The Soundex code.

---

## Web Helper Functions

### Function: `AccessWebVariables`

```4d
Function AccessWebVariables($body : Boolean)->$variables : Object
```

**Description:**
Eases the access to web variables, either passed as URL (GET) or inside the body (POST). If `$body` is true, it includes the body content.

**Parameters:**
- `$body` (Boolean): If true, includes the body content.

**Returns:**
- `$variables` (Object): An object containing the web variables as key/value pairs.

---

### Function: `AccessWebHeader`

```4d
Function AccessWebHeader->$variables : Object
```

**Description:**
Eases the access to web headers.

It returns the content as object as key/value, such as 
{"User-Agend":"browser";"Cookie":"C=HELLO"}
Access the values as:
$user:=string($variables.Cookie)  // returns "" if cookie Header does not exists

**Returns:**
- `$variables` (Object): An object containing the web headers as key/value pairs.


---

### Function: `URLEncoder`

```4d
Function URLEncoder($url : Text; $encoding : Text)->$result : Text
```

**Description:**
Encodes a URL, converting special characters to their percent-encoded equivalents.

**Parameters:**
- `$url` (Text): The URL to encode.
- `$encoding` (Text): The encoding format (e.g., UTF-8 or ISO-8859-1).

**Returns:**
- `$result` (Text): The encoded URL.

---

### Function: `loadImageFromURL`

```4d
Function loadImageFromURL($url)->$image : Picture
```

**Description:**
Loads an image from a given URL.

**Parameters:**
- `$url` (Text): The URL of the image.

**Returns:**
- `$image` (Picture): The loaded image.

---

### Function: `getWebServerAddress`

```4d
Function getWebServerAddress->$url : Text
```

**Description:**
Gets the web server address.

**Returns:**
- `$url` (Text): The web server address.

---

## ORDA Helper Functions

### Function: `ORDA_GetRelationSelection`

```4d
Function ORDA_GetRelationSelection($fromSelection : Object; $TargetClassName : Text; $MaxDepth : Integer)->$relatedSelection : Object
```

**Description:**
Joins an entity selection to a related data class and returns the selection.

**Parameters:**
- `$fromSelection` (Object): The entity selection to join.
- `$TargetClassName` (Text): The name of the target data class.
- `$MaxDepth` (Integer): The maximum depth for the relation.

**Returns:**
- `$relatedSelection` (Object): The related entity selection.

---

### Function: `ORDA_GetFieldTypeFromPath`

```4d
Function ORDA_GetFieldTypeFromPath($path : Text)->$fieldtyp : Integer
```

**Description:**
Returns the field type for a given path.

**Parameters:**
- `$path` (Text): The path to the field (e.g., Customer.name).

**Returns:**
- `$fieldtyp` (Integer): The field type.

---

### Function: `ORDA_TableNameToTableNum`

```4d
Function ORDA_TableNameToTableNum($name)->$number : Integer
```

**Description:**
Converts a class name to a table number.

**Parameters:**
- `$name` (Text): The name of the class.

**Returns:**
- `$number` (Integer): The table number.

---

## Internal Functions

### Function: `_ORDA_FindRelationPath`

```4d
Function _ORDA_FindRelationPath($FromClassName : Text; $ToClassName : Text; $MaxDepth : Integer)->$pathout : Text
```

**Description:**
Finds the path between two classes.

**Parameters:**
- `$FromClassName` (Text): The name of the source class.
- `$ToClassName` (Text): The name of the target class.
- `$MaxDepth` (Integer): The maximum depth for the relation.

**Returns:**
- `$pathout` (Text): The path between the classes.

---

### Function: `_flattenCollObject`

```4d
Function _flattenCollObject($ent : Object; $subent : Object; $curName : Text; $fullName : Boolean)
```

**Description:**
Flattens a nested object within a collection.

**Parameters:**
- `$ent` (Object): The parent object.
- `$subent` (Object): The nested object.
- `$curName` (Text): The current name.
- `$fullName` (Boolean): If true, uses full names for nested objects.

---
