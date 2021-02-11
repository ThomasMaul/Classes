//%attributes = {}
// requires external file!!!

var $path : Text
var $xml : 4D:C1709.File
var $structure; $table; $field; $relation; $relations; $index; $indexes : Object

$path:="/Users/thomas/Documents/4D/4DVerwaltung/Project/Sources/catalog.4DCatalog"
$xml:=File:C1566($path).getText()
//$path:=Convert path POSIX to system($path)
//$xml:=Document to text($path)
$structure:=cs:C1710.StructureInfo.new($xml)

$table:=$structure.getTableInfo(New object:C1471("name"; "Kunden"))
$table:=$structure.getTableInfo(New object:C1471("uuid"; "B54858F5EF4DA4409FFEA45A36030BA8"))
$table:=$structure.getTableInfo(New object:C1471("ptr"; ->[Table_1:1]))

$field:=$structure.getFieldInfo(New object:C1471("table_name"; "Table_1"; "field_name"; "anotherfield"))
$field:=$structure.getFieldInfo(New object:C1471("uuid"; "765C8B6456C04E8A9060E30729499663"))
$field:=$structure.getFieldInfo(New object:C1471("ptr"; ->[Table_1:1]testing_only:2))

$relation:=$structure.getRelationInfo(New object:C1471("uuid"; "AF5A443934107E48870113FDBA3079DB"))
$relation:=$structure.getRelationInfo(New object:C1471("fromTable_name"; "Auftrage"; "relationName"; "Kunde"))

$relations:=$structure.getRelationInfos(New object:C1471("fromTable_name"; "Auftrage"; "toTable_name"; "Kunden"))
$relations:=$structure.getRelationInfos(New object:C1471("Table_name1"; "Auftrage"; "Table_name2"; "Kunden"))  // any direction
$relations:=$structure.getRelationInfos(New object:C1471("Table_name"; "Auftrage"))  // any direction
$relations:=$structure.getRelationInfos(New object:C1471("fromTable_name"; "Kunden"))
$relations:=$structure.getRelationInfos(New object:C1471("fromTable_name"; "A@"))
$relations:=$structure.getRelationInfos(New object:C1471("toTable_name"; "Auftrage"))

$index:=$structure.getIndexInfo(New object:C1471("uuid"; "DDD2D5C46CC74D8CA1B12B2DE61735A6"))
$index:=$structure.getIndexInfo(New object:C1471("name"; "LKZ_PLZ"))

$indexes:=$structure.getIndexInfos(New object:C1471("table_name"; "Kunden"))
$indexes:=$structure.getIndexInfos(New object:C1471("table_name"; "Kunden"; "field_name"; "PLZ"))  // could be more than one index