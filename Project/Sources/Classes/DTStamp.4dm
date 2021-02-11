Class constructor($date : Date; $time : Time; $startdate : Date)
	var $start : Date
	If (Count parameters:C259>=3)
		$start:=$startdate
	Else 
		$start:=!1980-01-01!
	End if 
	If (Count parameters:C259>=2)
		This:C1470.ts:=(($date-$start)*86400)+($time+0)  //  86400 = 60*60*24
	Else 
		This:C1470.ts:=((Current date:C33-$start)*86400)+(Current time:C178+0)
	End if 
	
Function GetDate($startdate : Date)->$date : Date
	var $start : Date
	If (Count parameters:C259>0)
		$start:=$startdate
	Else 
		$start:=!1980-01-01!
	End if 
	$date:=$start+(This:C1470.ts\86400)
	
Function GetString($startdate : Date)->$date : Text
	var $start : Date
	If (Count parameters:C259>0)
		$start:=$startdate
	Else 
		$start:=!1980-01-01!
	End if 
	$date:=String:C10($start+(This:C1470.ts\86400); 7)+" - "+Time string:C180((This:C1470.ts%86400)+?00:00:00?)
	
Function GetValues($date : Pointer; $time : Pointer; $startdate : Date)
	var $start : Date
	If (Count parameters:C259>=3)
		$start:=$startdate
	Else 
		$start:=!1980-01-01!
	End if 
	ASSERT:C1129(Count parameters:C259>=2; "Not enough parameters given")
	ASSERT:C1129(Type:C295($date->)=Is date:K8:7; "First parameter must be pointer on date")
	ASSERT:C1129(Type:C295($time->)=Is time:K8:8; "First parameter must be pointer on time")
	$date->:=$start+(This:C1470.ts\86400)
	$time->:=(This:C1470.ts%86400)+?00:00:00?
	
Function GetObject($startdate : Date)->$date : Object
	var $start : Date
	If (Count parameters:C259>=3)
		$start:=$startdate
	Else 
		$start:=!1980-01-01!
	End if 
	$date:=New object:C1471
	$date.date:=$start+(This:C1470.ts\86400)
	$date.time:=(This:C1470.ts%86400)+?00:00:00?