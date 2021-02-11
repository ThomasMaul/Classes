Class constructor($StructureXML : Text)
	var $obj : cs:C1710.XMLToObject
	
	If ($StructureXML#"")
		$obj:=cs:C1710.XMLToObject.new($StructureXML)
		This:C1470.structure:=$obj.get(New collection:C1472("table"; "field"; "relation"; "index"; "primary_key"))
	Else 
		This:C1470.structure:=New object:C1471
	End if 
	
Function get()->$result : Object
	$result:=This:C1470.structure
	
Function getTableInfo($info : Object)->$result : Object
	$result:=This:C1470._Structure_Read("table"; $info)
	
Function getFieldInfo($info : Object)->$result : Object
	$result:=This:C1470._Structure_Read("field"; $info)
	
Function getRelationInfo($info : Object)->$result : Object
	$result:=This:C1470._Structure_Read("relation"; $info)
	
Function getRelationInfos($info : Object)->$result : Object
	$result:=This:C1470._Structure_Read("relations"; $info)
	
Function getIndexInfo($info : Object)->$result : Object
	$result:=This:C1470._Structure_Read("index"; $info)
	
Function getIndexInfos($info : Object)->$result : Object
	$result:=This:C1470._Structure_Read("indexes"; $info)
	
	
	
Function _Structure_Read($what : Text; $info : Object)->$result : Object
	// function, called on object with structure info
	// 1st parameter defines what info you want, could be Table or Field
	// 2nd/3rd parameter is object name (table name, field name)
	
	C_COLLECTION:C1488($tables; $fields; $indexes; $relations; $in; $out)
	C_OBJECT:C1216($result; $table; $field; $index; $relation)
	C_POINTER:C301($ptr)
	C_TEXT:C284($name; $Fieldname)
	
	Case of 
		: ($what="table")
			If (This:C1470.structure.table#Null:C1517)
				Case of 
					: ($info.name#Null:C1517)
						$tables:=This:C1470.structure.table.query("name=:1"; $info.name)
					: ($info.uuid#Null:C1517)
						$tables:=This:C1470.structure.table.query("uuid=:1"; $info.uuid)
					: ($info.ptr#Null:C1517)
						$name:=Table name:C256($info.ptr)
						If ($name#"")
							$tables:=This:C1470.structure.table.query("name=:1"; $name)
						End if 
				End case 
				If ($tables.length>0)
					$result:=$tables[0]
				End if 
			End if 
			
		: ($what="field")
			If (This:C1470.structure.table#Null:C1517)
				Case of 
					: (($info.table_name#Null:C1517) & ($info.field_name#Null:C1517))
						$tables:=This:C1470.structure.table.query("name=:1"; $info.table_name)
						If ($tables.length>0)
							$table:=$tables[0]
							If ($table.field#Null:C1517)
								$fields:=$table.field.query("name=:1"; $info.field_name)
								If ($fields.length>0)
									$result:=$fields[0]
								End if 
							End if 
						End if 
						
					: ($info.uuid#Null:C1517)
						For each ($table; This:C1470.structure.table) Until ($fields.length>0)
							If ($table.field#Null:C1517)
								$fields:=$table.field.query("uuid=:1"; $info.uuid)
							End if 
						End for each 
						If ($fields.length>0)
							$result:=$fields[0]
						End if 
						
					: ($info.ptr#Null:C1517)
						$name:=Table name:C256($info.ptr)
						If ($name#"")
							$tables:=This:C1470.structure.table.query("name=:1"; $name)
							If ($tables.length>0)
								$table:=$tables[0]
								$ptr:=$info.ptr
								$Fieldname:=Field name:C257($ptr)
								If ($table.field#Null:C1517)
									$fields:=$table.field.query("name=:1"; $Fieldname)
									If ($fields.length>0)
										$result:=$fields[0]
									End if 
								End if 
							End if 
						End if 
				End case 
				
			End if 
			
		: ($what="relation")
			If (This:C1470.structure.table#Null:C1517)
				Case of 
					: ($info.uuid#Null:C1517)
						$relations:=This:C1470.structure.relation.query("uuid=:1"; $info.uuid)
						If ($relations.length>0)
							$result:=$relations[0]
						End if 
						
					: (($info.fromTable_name#Null:C1517) & ($info.relationName#Null:C1517))
						$relations:=This:C1470.structure.relation.query("name_1toN=:1 or name_Nto1=:1"; $info.relationName)
						For each ($relation; $relations)
							$in:=$relation.related_field.query("kind='source' and field_ref.table_ref.name=:1"; $info.fromTable_name)
							If ($in.length>0)
								$result:=$relation
							End if 
						End for each 
					Else 
						$result:=New object:C1471
				End case 
			End if 
			
		: ($what="relations")
			// return collection in object, as it could be no, one or several index using this field
			// needs table name and field name
			If (This:C1470.structure.table#Null:C1517)
				Case of 
					: (($info.fromTable_name#Null:C1517) & ($info.toTable_name#Null:C1517))
						For each ($relation; This:C1470.structure.relation)
							$in:=$relation.related_field.query("kind='source' and field_ref.table_ref.name=:1"; $info.fromTable_name)
							$out:=$relation.related_field.query("kind='destination' and field_ref.table_ref.name=:1"; $info.toTable_name)
							If (($in.length>0) & ($out.length>0))
								If ($result=Null:C1517)
									$result:=New object:C1471("relations"; New collection:C1472($relation))
								Else 
									$result.relations.push($relation)
								End if 
							End if 
						End for each 
						
					: (($info.Table_name1#Null:C1517) & ($info.Table_name2#Null:C1517))
						For each ($relation; This:C1470.structure.relation)
							$in:=$relation.related_field.query("field_ref.table_ref.name=:1"; $info.Table_name1)
							$out:=$relation.related_field.query("field_ref.table_ref.name=:1"; $info.Table_name2)
							If (($in.length>0) & ($out.length>0))
								If ($result=Null:C1517)
									$result:=New object:C1471("relations"; New collection:C1472($relation))
								Else 
									$result.relations.push($relation)
								End if 
							End if 
						End for each 
						
					: ($info.Table_name#Null:C1517)
						For each ($relation; This:C1470.structure.relation)
							$in:=$relation.related_field.query("field_ref.table_ref.name=:1"; $info.Table_name)
							If ($in.length>0)
								If ($result=Null:C1517)
									$result:=New object:C1471("relations"; New collection:C1472($relation))
								Else 
									$result.relations.push($relation)
								End if 
							End if 
						End for each 
						
					: (($info.fromTable_name#Null:C1517) & ($info.relationName#Null:C1517))
						$relations:=This:C1470.structure.relation.query("name_1toN=:1 or name_Nto1=:1"; $info.relationName)
						For each ($relation; $relations)
							$in:=$relation.related_field.query("kind='source' and field_ref.table_ref.name=:1"; $info.fromTable_name)
							If ($in.length>0)
								If ($result=Null:C1517)
									$result:=New object:C1471("relations"; New collection:C1472($relation))
								Else 
									$result.relations.push($relation)
								End if 
							End if 
						End for each 
						
					: ($info.fromTable_name#Null:C1517)
						For each ($relation; This:C1470.structure.relation)
							$in:=$relation.related_field.query("kind='source' and field_ref.table_ref.name=:1"; $info.fromTable_name)
							If ($in.length>0)
								If ($result=Null:C1517)
									$result:=New object:C1471("relations"; New collection:C1472($relation))
								Else 
									$result.relations.push($relation)
								End if 
							End if 
						End for each 
						
					: ($info.toTable_name#Null:C1517)
						For each ($relation; This:C1470.structure.relation)
							$in:=$relation.related_field.query("kind='destination' and field_ref.table_ref.name=:1"; $info.toTable_name)
							If ($in.length>0)
								If ($result=Null:C1517)
									$result:=New object:C1471("relations"; New collection:C1472($relation))
								Else 
									$result.relations.push($relation)
								End if 
							End if 
						End for each 
						
				End case 
			End if 
			
		: ($what="index")
			// return collection in object, as it could be no, one or several index using this field
			// needs table name and field name
			If (This:C1470.structure.table#Null:C1517)
				Case of 
					: ($info.name#Null:C1517)
						$indexes:=This:C1470.structure.index.query("name=:1"; $info.name)
					: ($info.uuid#Null:C1517)
						$indexes:=This:C1470.structure.index.query("uuid=:1"; $info.uuid)
				End case 
				
				If ($indexes.length>0)
					$result:=$indexes[0]
				End if 
			End if 
			
		: ($what="indexes")
			// return collection in object, as it could be no, one or several index using this.structure field
			// needs table name and field name
			If (This:C1470.structure.table#Null:C1517)
				Case of 
					: (($info.table_name#Null:C1517) & ($info.field_name#Null:C1517))
						For each ($index; This:C1470.structure.index)
							// field_ref could be an object or a collection
							// field_ref is also used for relations, so we cannot convert to collection based on name
							If (Value type:C1509($index.field_ref)=Is object:K8:27)
								If (String:C10($index.field_ref.table_ref.name)=$info.table_name)
									If (String:C10($index.field_ref.name)=$info.field_name)
										If ($result=Null:C1517)
											$result:=New object:C1471("index"; New collection:C1472($index))
										Else 
											$result.index.push($index)
										End if 
									End if 
								End if 
							Else 
								$in:=$index.field_ref.query("table_ref.name=:1 and name=:2"; $info.table_name; $info.field_name)
								If ($in.length>0)
									If ($result=Null:C1517)
										$result:=New object:C1471("index"; New collection:C1472($index))
									Else 
										$result.index.push($index)
									End if 
								End if 
							End if 
						End for each 
						
					: ($info.table_name#Null:C1517)
						For each ($index; This:C1470.structure.index)
							// field_ref could be an object or a collection
							// field_ref is also used for relations, so we cannot convert to collection based on name
							If (Value type:C1509($index.field_ref)=Is object:K8:27)
								If (String:C10($index.field_ref.table_ref.name)=$info.table_name)
									If ($result=Null:C1517)
										$result:=New object:C1471("index"; New collection:C1472($index))
									Else 
										$result.index.push($index)
									End if 
								End if 
							Else 
								$in:=$index.field_ref.query("table_ref.name=:1"; $info.table_name)
								If ($in.length>0)
									If ($result=Null:C1517)
										$result:=New object:C1471("index"; New collection:C1472($index))
									Else 
										$result.index.push($index)
									End if 
								End if 
							End if 
							
						End for each 
						
				End case 
			End if 
			
		Else 
			// nothing
			
	End case 
	
	
	