//%attributes = {}
If (False:C215)  // only needed when you modify the structure and don't want to restart
	cs:C1710.StructureInfo.me.refresh()
End if 

var $table:=cs:C1710.StructureInfo.me.getTableInfo(New object:C1471("name"; "Table_1"))


$table:=cs:C1710.StructureInfo.me.getTableInfo({name: "Customer"})
$table:=cs:C1710.StructureInfo.me.getTableInfo(New object:C1471("uuid"; "B54858F5EF4DA4409FFEA45A36030BA8"))
$table:=cs:C1710.StructureInfo.me.getTableInfo(New object:C1471("ptr"; ->[Table_1:1]))

var $field:=cs:C1710.StructureInfo.me.getFieldInfo({table_name: "Table_1"; field_name: "anotherfield"})
$field:=cs:C1710.StructureInfo.me.getFieldInfo({uuid: "765C8B6456C04E8A9060E30729499663"})
$field:=cs:C1710.StructureInfo.me.getFieldInfo(New object:C1471("ptr"; ->[Table_1:1]testing_only:2))

var $relation:=cs:C1710.StructureInfo.me.getRelationInfo(New object:C1471("uuid"; "AF5A443934107E48870113FDBA3079DB"))
$relation:=cs:C1710.StructureInfo.me.getRelationInfo(New object:C1471("fromTable_name"; "Auftrage"; "relationName"; "Kunde"))

var $relations:=cs:C1710.StructureInfo.me.getRelationInfos(New object:C1471("fromTable_name"; "Invoice"; "toTable_name"; "Customer"))
$relations:=cs:C1710.StructureInfo.me.getRelationInfos(New object:C1471("Table_name1"; "Invoice"; "Table_name2"; "Customer"))  // any direction
$relations:=cs:C1710.StructureInfo.me.getRelationInfos(New object:C1471("Table_name"; "Invoice"))  // any direction
$relations:=cs:C1710.StructureInfo.me.getRelationInfos(New object:C1471("fromTable_name"; "Customer"))
$relations:=cs:C1710.StructureInfo.me.getRelationInfos(New object:C1471("fromTable_name"; "I@"))
$relations:=cs:C1710.StructureInfo.me.getRelationInfos(New object:C1471("toTable_name"; "Invoice"))

var $index:=cs:C1710.StructureInfo.me.getIndexInfo(New object:C1471("uuid"; "DDD2D5C46CC74D8CA1B12B2DE61735A6"))
$index:=cs:C1710.StructureInfo.me.getIndexInfo(New object:C1471("name"; "LKZ_PLZ"))

var $indexes:=cs:C1710.StructureInfo.me.getIndexInfos(New object:C1471("table_name"; "Kunden"))
$indexes:=cs:C1710.StructureInfo.me.getIndexInfos(New object:C1471("table_name"; "Kunden"; "field_name"; "PLZ"))  // could be more than one index


var $all:=cs:C1710.StructureInfo.me.get()
