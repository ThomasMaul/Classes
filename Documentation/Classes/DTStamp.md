## Description
Helper methods for timestamp, counting seconds past midnight after given date
by default date is 1980-1-1, can be set to others.

## Constructor ($date : Date; $time : Time; {$startdate : Date})
$startdate is optional, when missing 1980-1-1

## GetDate($startdate : Date)->$date : Date

## GetString($startdate : Date)->$date : Text

## GetValues($date : Pointer; $time : Pointer; $startdate : Date)
Use like
```4d
var $date:=date
var $time:=time
$ts:=cs.DTStamp().new()
$ts.GetValues(->$date;->$time)
```

## GetObject($startdate : Date)->$date : Object
$date.date contains date, $date.time contains time
