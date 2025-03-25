ThomasMaul: create documentation for my class functions

GitHub Copilot: Here is the documentation for your class functions in the `DTStamp` class:

### DTStamp Class

#### Constructor
```4d
Class constructor($date : Date; $time : Time; $startdate : Date)
```
- **Parameters:**
  - `$date` (Date): The date to be used for the timestamp.
  - `$time` (Time): The time to be used for the timestamp.
  - `$startdate` (Date): The start date for the timestamp calculation. Defaults to `1980-01-01` if not provided.
- **Description:** Initializes the timestamp (`ts`) based on the provided date, time, and start date. If only the date and time are provided, the current date and time are used.

#### GetDate
```4d
Function GetDate($startdate : Date)->$date : Date
```
- **Parameters:**
  - `$startdate` (Date): The start date for the timestamp calculation. Defaults to `1980-01-01` if not provided.
- **Returns:** `$date` (Date): The calculated date based on the timestamp and start date.
- **Description:** Returns the date part of the timestamp.

#### GetString
```4d
Function GetString($startdate : Date)->$date : Text
```
- **Parameters:**
  - `$startdate` (Date): The start date for the timestamp calculation. Defaults to `1980-01-01` if not provided.
- **Returns:** `$date` (Text): The string representation of the date and time based on the timestamp and start date.
- **Description:** Returns the string representation of the date and time part of the timestamp.

#### GetValues
```4d
Function GetValues($date : Pointer; $time : Pointer; $startdate : Date)
```
- **Parameters:**
  - `$date` (Pointer): Pointer to a date variable to store the calculated date.
  - `$time` (Pointer): Pointer to a time variable to store the calculated time.
  - `$startdate` (Date): The start date for the timestamp calculation. Defaults to `1980-01-01` if not provided.
- **Description:** Sets the values of the provided date and time pointers based on the timestamp and start date. Asserts that the correct number and types of parameters are provided.

#### GetObject
```4d
Function GetObject($startdate : Date)->$date : Object
```
- **Parameters:**
  - `$startdate` (Date): The start date for the timestamp calculation. Defaults to `1980-01-01` if not provided.
- **Returns:** `$date` (Object): An object containing the calculated date and time based on the timestamp and start date.
- **Description:** Returns an object with the date and time parts of the timestamp.

### Example Usage
```4d
// Creating an instance of DTStamp
var dtStamp : cs.DTStamp
dtStamp:=cs.DTStamp.new(Current date; Current time; !2000-01-01!)

// Getting the date
var date : Date
date:=dtStamp.GetDate(!2000-01-01!)

// Getting the string representation
var dateString : Text
dateString:=dtStamp.GetString(!2000-01-01!)

// Getting the values
var datePointer : Pointer
var timePointer : Pointer
datePointer:=->date
timePointer:=->time
dtStamp.GetValues(datePointer; timePointer; !2000-01-01!)

// Getting the object
var dateObject : Object
dateObject:=dtStamp.GetObject(!2000-01-01!)
```

This documentation provides an overview of the functions available in the `DTStamp` class, their parameters, return values, and descriptions of their functionality.