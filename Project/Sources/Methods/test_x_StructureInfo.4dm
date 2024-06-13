//%attributes = {}
var $table:=cs:C1710.StructureInfo.me.getTableInfo(New object:C1471("name"; "Table_1"))


$table:=cs:C1710.StructureInfo.me.getTableInfo(New object:C1471("name"; "Kunden"))
$table:=cs:C1710.StructureInfo.me.getTableInfo(New object:C1471("uuid"; "B54858F5EF4DA4409FFEA45A36030BA8"))
$table:=cs:C1710.StructureInfo.me.getTableInfo(New object:C1471("ptr"; ->[Table_1:1]))

var $field:=cs:C1710.StructureInfo.me.getFieldInfo(New object:C1471("table_name"; "Table_1"; "field_name"; "anotherfield"))
$field:=cs:C1710.StructureInfo.me.getFieldInfo(New object:C1471("uuid"; "765C8B6456C04E8A9060E30729499663"))
$field:=cs:C1710.StructureInfo.me.getFieldInfo(New object:C1471("ptr"; ->[Table_1:1]testing_only:2))

var $relation:=cs:C1710.StructureInfo.me.getRelationInfo(New object:C1471("uuid"; "AF5A443934107E48870113FDBA3079DB"))
$relation:=cs:C1710.StructureInfo.me.getRelationInfo(New object:C1471("fromTable_name"; "Auftrage"; "relationName"; "Kunde"))

var $relations:=cs:C1710.StructureInfo.me.getRelationInfos(New object:C1471("fromTable_name"; "Auftrage"; "toTable_name"; "Kunden"))
$relations:=cs:C1710.StructureInfo.me.getRelationInfos(New object:C1471("Table_name1"; "Auftrage"; "Table_name2"; "Kunden"))  // any direction
$relations:=cs:C1710.StructureInfo.me.getRelationInfos(New object:C1471("Table_name"; "Auftrage"))  // any direction
$relations:=cs:C1710.StructureInfo.me.getRelationInfos(New object:C1471("fromTable_name"; "Kunden"))
$relations:=cs:C1710.StructureInfo.me.getRelationInfos(New object:C1471("fromTable_name"; "A@"))
$relations:=cs:C1710.StructureInfo.me.getRelationInfos(New object:C1471("toTable_name"; "Auftrage"))

var $index:=cs:C1710.StructureInfo.me.getIndexInfo(New object:C1471("uuid"; "DDD2D5C46CC74D8CA1B12B2DE61735A6"))
$index:=cs:C1710.StructureInfo.me.getIndexInfo(New object:C1471("name"; "LKZ_PLZ"))

var $indexes:=cs:C1710.StructureInfo.me.getIndexInfos(New object:C1471("table_name"; "Kunden"))
$indexes:=cs:C1710.StructureInfo.me.getIndexInfos(New object:C1471("table_name"; "Kunden"; "field_name"; "PLZ"))  // could be more than one index