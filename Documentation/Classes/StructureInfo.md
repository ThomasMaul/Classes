<!-- returns information for a given 4D structure -->
## Description
parses a 4D structure and allows easy access to definition
requires class XMLToObject

## constructur (structureXML :text)
pass the catalog.xml file as text

## get() -> object
returns full object representing the structure

## getTableInfo(info: object) -> object
return information about a given table.
Example usage
```4d
$table:=$structure.getTableInfo(New object("name"; "Kunden"))
$table:=$structure.getTableInfo(New object("uuid"; "B54858F5EF4DA4409FFEA45A36030BA8"))
$table:=$structure.getTableInfo(New object("ptr"; ->[Table_1]))
```

# getFieldInfo(info: object) -> object
return information about a given field.
Example usage
```4d
$field:=$structure.getFieldInfo(New object("table_name"; "Table_1"; "field_name"; "anotherfield"))
$field:=$structure.getFieldInfo(New object("uuid"; "765C8B6456C04E8A9060E30729499663"))
$field:=$structure.getFieldInfo(New object("ptr"; ->[Table_1]testing_only))

```

# getRelationInfo(info: object) -> object
return information about a given relation.
Example usage
```4d
$relation:=$structure.getRelationInfo(New object("uuid"; "AF5A443934107E48870113FDBA3079DB"))
$relation:=$structure.getRelationInfo(New object("fromTable_name"; "Auftrage"; "relationName"; "Kunde"))
```

# getRelationInfos(info: object) -> object
return information about many relations.
Example usage
```4d
$relations:=$structure.getRelationInfos(New object("fromTable_name"; "Auftrage"; "toTable_name"; "Kunden"))
$relations:=$structure.getRelationInfos(New object("Table_name1"; "Auftrage"; "Table_name2"; "Kunden"))  // any direction
$relations:=$structure.getRelationInfos(New object("Table_name"; "Auftrage"))  // any direction
$relations:=$structure.getRelationInfos(New object("fromTable_name"; "Kunden"))
$relations:=$structure.getRelationInfos(New object("fromTable_name"; "A@"))
$relations:=$structure.getRelationInfos(New object("toTable_name"; "Auftrage"))
```

# getIndexInfo(info: object) -> object
return information about a given index.
Example usage
```4d
$$index:=$structure.getIndexInfo(New object("uuid"; "DDD2D5C46CC74D8CA1B12B2DE61735A6"))
$index:=$structure.getIndexInfo(New object("name"; "LKZ_PLZ"))  // combined index
```

# getIndexInfos(info: object) -> object
return information about many indices.
Example usage
```4d
$indexes:=$structure.getIndexInfos(New object("table_name"; "Kunden"))
$indexes:=$structure.getIndexInfos(New object("table_name"; "Kunden"; "field_name"; "PLZ"))  // could be more than one index
```

