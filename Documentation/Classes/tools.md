# Description
Collection of helper methods

&nbsp;
# Generic
## CalendarWeek (date: date) -> week : nteger
return calenderweek based on DIN 1355 (ISO/R 2015-1971) / ISO 8601

## HexToDec (hex: text) -> dec : integer
converts hex to decimal, pass hex as "A2b3"

## ResizeArray (Array : pointer; newSize: integer) 
Resize an Array

&nbsp;
# GUI
## AdjustWindowSize (formname: text; formtable: pointer)
checks if current window is fully visible and large enough for given form

## GetWindowSizeInObject->$obj : Object
read current window position and stores left/top/right/bottom in object

## SetWindowSizeFromObject($obj : Object)
restores current window position from object, object to be created using .GetWindowSizeInObject()
  
## OpenFormWindowStack($formular : Text; $parawindowtyp : Integer; $tablePtr : Pointer)->$win : Integer  
Opens a window stacked above the current one

&nbsp;
# check specific
## CheckIBAN (iBAN: text) -> correct : boolean
check IBAN number if valid (true/false)

## CheckEmailAddress(email: text) -> correct : boolean
check email if valid (true/false)

&nbsp;
# Filter text
## Filter_OnlyNumeric ($text : Text; $special : Boolean)->$result : Text
allows only numeric chars, if special=true also -., (system specific decimal and thousand separators)

## Filter_RemoveWildcard ($text : Text)->$result : Text
removes @ from string

## Filter_RemoveLeadingEndingBlanks ($text : Text)->$result : Text
removes leading or ending blanks (char 34) from string

## Filter_RemoveLeadingZero ($text : Text)->$result : Text
removes leading 0 from string

## Filter_RemoveTabReturn ($text : Text)->$result : Text
removes char 9, 10 or 13 from string

## FindNextNewLine ($text : Text; { $start : Integer} ) -> $resultpos : Integer
Returns position of next new line char, useful if it could be 10, 13 or 13/10

## KoelnerPhonetik($word : Text)->$soundex : Text
[German Wikipedia](https://de.wikipedia.org/wiki/Kölner_Phonetik])
[English Wikipedia](https://en.wikipedia.org/wiki/Cologne_phonetics)

## Soundex($word : Text; $strength : Integer)->$soundex : Text
[English Wikipedia](https://en.wikipedia.org/wiki/Soundex)

&nbsp;
# Web Helper
## AccessWebVariables($includeBody: boolean) -> $variables:object
Ease the access to web variables, either passed as URL (GET) or inside the body (POST). To read body pass true as parameter
It returns the content as object as key/value, such as 
{"user":"abc";"password":"123"}
Access the values as:
$user:=string($variables.user)  // returns "" if user web variable is not set

## AccessWebHeader -> $variables:object
Ease the access to web headers
It returns the content as object as key/value, such as 
{"User-Agend":"browser";"Cookie":"C=HELLO"}
Access the values as:
$user:=string($variables.Cookie)  // returns "" if cookie Header does not exists

## URLEncoder($url : Text; $encoding : Text)->$result : Text
example:  "www.test.com/my method"  contains a blank, so needs to be converted to "www.test.com/my%20method"
$encoding could be UTF-8 or ISO-8859-1


&nbsp;
# ORDA helper
## ORDA_GetRelationSelection ($fromSelection : Object; $TargetClassName : Text;{ $MaxDepth : Integer})->$relatedSelection : Object
join an entity selection to a related data class and return selection
useful if you have a selection and know where you want to go, but not the name of the relation or the path

## ORDA_GetFieldTypeFromPath($path : Text)->$fieldtyp : Integer
returns field type for a given path
like Customer.name or Invoice.Customer.Name or InvoiceItem.Invoice.Customer.Name

