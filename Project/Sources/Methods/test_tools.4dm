//%attributes = {}
var $tools : cs:C1710.tools
var $num; $week : Integer
var $ibans : Collection
var $iban : Text

$tools:=cs:C1710.tools.new()


$num:=$tools.HexToDec("a2b3")
ASSERT:C1129($num=41651; "Error in HexToDec")

$week:=$tools.CalendarWeek(!2012-12-31!)
ASSERT:C1129($week=1; "Error in Calendarweek")
$week:=$tools.CalendarWeek(!2003-12-23!)
ASSERT:C1129($week=52; "Error in Calendarweek")
$week:=$tools.CalendarWeek(!2003-12-29!)
ASSERT:C1129($week=1; "Error in Calendarweek")

$ibans:=New collection:C1472("DE02120300000000202051"; "DE02500105170137075030"; "AT026000000001349870"; "AT022081500000698597"; \
"LI0308803103143000000"; "CH0200784102000140304")
For each ($iban; $ibans)
	ASSERT:C1129($tools.CheckIBAN($iban)=True:C214; "Error in IBAN Check")
End for each 
ASSERT:C1129($tools.CheckIBAN("DE02500105170137075031")=False:C215; "Error in IBAN Check")


ASSERT:C1129($tools.Filter_OnlyNumeric("hallo")=""; "Error in FilterOnlyNumeric")
ASSERT:C1129($tools.Filter_OnlyNumeric("ha1llo")="1"; "Error in FilterOnlyNumeric")
ASSERT:C1129($tools.Filter_OnlyNumeric("-5")="5"; "Error in FilterOnlyNumeric")
ASSERT:C1129($tools.Filter_OnlyNumeric("-5"; True:C214)="-5"; "Error in FilterOnlyNumeric")
ASSERT:C1129($tools.Filter_OnlyNumeric(String:C10(2.3))="23"; "Error in FilterOnlyNumeric")
ASSERT:C1129($tools.Filter_OnlyNumeric(String:C10(2.3); True:C214)=String:C10(2.3); "Error in FilterOnlyNumeric")


ASSERT:C1129($tools.Filter_RemoveWildcard("pass@word")="password"; "Error in Filter_RemoveWildcard")
ASSERT:C1129($tools.Filter_RemoveLeadingEndingBlanks(" password ")="password"; "Error in Filter_RemoveLeadingEndingBlanks")
ASSERT:C1129($tools.Filter_RemoveLeadingZero("000123")="123"; "Error in Filter_RemoveLeadingZero")
ASSERT:C1129($tools.Filter_RemoveTabReturn("test\r\t\ntest")="testtest"; "Error in Filter_RemoveTabReturn")

ASSERT:C1129($tools.FindNextNewLine("test\ntest")=5; "Error in FindNextNewLine")
ASSERT:C1129($tools.FindNextNewLine("test\ntest\rtest"; 6)=10; "Error in FindNextNewLine")

ASSERT:C1129($tools.KoelnerPhonetik("Schusterei Schmidt")=$tools.KoelnerPhonetik("shusterai schmit"); "Error in Kölner Phonetik")
ASSERT:C1129($tools.KoelnerPhonetik("Schusterei Schmidt")=$tools.KoelnerPhonetik("schuster schmit"); "Error in Kölner Phonetik")
ASSERT:C1129($tools.KoelnerPhonetik("Schusterei Schmidt")#$tools.KoelnerPhonetik("schuster hit"); "Error in Kölner Phonetik")

ASSERT:C1129($tools.Soundex("Schusterei Schmidt")#$tools.Soundex("shusterai schmit"); "Error in Soundex")
ASSERT:C1129($tools.Soundex("Robert")=$tools.Soundex("Rubert"); "Error in Soundex")
ASSERT:C1129($tools.Soundex("Apple Computer")=$tools.Soundex("Able Komputer"); "Error in Soundex")


If (Get call chain:C1662.length=1)  // direct call, not via global test
	ALERT:C41("Done")
End if 

