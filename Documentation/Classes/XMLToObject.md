## XMLToObject Class Documentation

### Description

The `XMLToObject` class provides functionality to convert XML data into an object for easy parsing. You can pass either a file object containing the XML or the XML content as text. The class will return the content as an object.

### Methods

#### init

```4d
cs.XMLToObject.new(File/Text; propnames collection)
```

**Description:**
Initializes a new instance of the `XMLToObject` class. You can pass the XML content as text or a file object. Optionally, you can pass a collection of property names that should always be set as a collection, not as object properties.

**Parameters:**
- `File/Text`: The XML content as text or a file object.
- `propnames collection` (optional): A collection of property names to be set as collections.

**Example:**
```4d
var $xmlToObject : cs.XMLToObject
$xmlToObject := cs.XMLToObject.new($xmlContent)
```

#### get

```4d
cs.XMLToObject.get() -> collection
```

**Description:**
Returns an object representing the XML content.

**Returns:**
- `collection`: An object representing the XML content.

**Example:**
```4d
var $xmlObject : Object
$xmlObject := $xmlToObject.get()
```
```

This documentation provides a clear description of the class and its methods, including their parameters and return values, along with example usage.