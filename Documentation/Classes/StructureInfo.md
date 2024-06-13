<!-- returns information for a given 4D structure -->
## Description
parses a 4D structure and allows easy access to definition

The class works as Singleton, so requires 4D 20 R5 or newer.
This allows direct usage without creating an instance upfront. 
Examples see below.



## get() -> object
returns full object representing the structure
```4d
$all:=cs.StructureInfo.me.get()
```

## getTableInfo(info: object) -> object
return information about a given table. Specify the table using name, uuid or a pointer

Example usage
```4d
$table:=cs.StructureInfo.me.getTableInfo({name: "Kunden")
$table:=cs.StructureInfo.me.getTableInfo(New object("uuid"; "B54858F5EF4DA4409FFEA45A36030BA8"))
$table:=cs.StructureInfo.me.getTableInfo(New object("ptr"; ->[Table_1]))
```

# getFieldInfo(info: object) -> object
return information about a given field. Specifiy the field using table_name AND field_name or uuid or ptr

Example usage
```4d
$field:=cs.StructureInfo.me.getFieldInfo(New object("table_name"; "Table_1"; "field_name"; "anotherfield"))
$field:=cs.StructureInfo.me.getFieldInfo(New object("uuid"; "765C8B6456C04E8A9060E30729499663"))
$field:=cs.StructureInfo.me.getFieldInfo(New object("ptr"; ->[Table_1]testing_only))

```

# getRelationInfo(info: object) -> object
return information about a given relation.
Example usage
```4d
$relation:=cs.StructureInfo.me.getRelationInfo(New object("uuid"; "AF5A443934107E48870113FDBA3079DB"))
$relation:=cs.StructureInfo.me.getRelationInfo(New object("fromTable_name"; "Auftrage"; "relationName"; "Kunde"))
```

# getRelationInfos(info: object) -> object
return information about many relations.
Example usage
```4d
$relations:=cs.StructureInfo.me.getRelationInfos(New object("fromTable_name"; "Auftrage"; "toTable_name"; "Kunden"))
$relations:=cs.StructureInfo.me.getRelationInfos(New object("Table_name1"; "Auftrage"; "Table_name2"; "Kunden"))  // any direction
$relations:=cs.StructureInfo.me.getRelationInfos(New object("Table_name"; "Auftrage"))  // any direction
$relations:=cs.StructureInfo.me.getRelationInfos(New object("fromTable_name"; "Kunden"))
$relations:=cs.StructureInfo.me.getRelationInfos(New object("fromTable_name"; "A@"))
$relations:=cs.StructureInfo.me.getRelationInfos(New object("toTable_name"; "Auftrage"))
```

# getIndexInfo(info: object) -> object
return information about a given index.
Example usage
```4d
$$index:=cs.StructureInfo.me.getIndexInfo(New object("uuid"; "DDD2D5C46CC74D8CA1B12B2DE61735A6"))
$index:=cs.StructureInfo.me.getIndexInfo(New object("name"; "LKZ_PLZ"))  // combined index
```

# getIndexInfos(info: object) -> object
return information about many indices.
Example usage
```4d
$indexes:=cs.StructureInfo.me.getIndexInfos(New object("table_name"; "Kunden"))
$indexes:=cs.StructureInfo.me.getIndexInfos(New object("table_name"; "Kunden"; "field_name"; "PLZ"))  // could be more than one index
```

