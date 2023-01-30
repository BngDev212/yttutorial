<?php

    function fnCheckData($conn, $tbl, $where){
        $SQLAdd = 
            "SELECT * FROM ".$tbl." WHERE ".$where;
        $query = mysqli_query($conn, $SQLAdd);
        if (mysqli_num_rows($query) > 0){
            return FALSE;
        } else {
            return TRUE;
        }
    }

    function fnGetItem($conn, $tbl, $val, $isWhere, $order, $limit){
		$index = 0;

        $SQLAdd = '';
        if ($isWhere != '') {
            $SQLAdd = 'WHERE';
        }
		
		$SQLAdd =
			"SELECT ".$val." FROM ".$tbl." ".$SQLAdd." ".$isWhere." ".$order." LIMIT 20";

		$query = mysqli_query($conn, $SQLAdd);

		if (mysqli_num_rows($query) > 0){
			while ($list = mysqli_fetch_assoc($query)) {
				$respon[] = $list;
			}
		} else {
			$respon[$index]['result'] = 'null';	
			$respon[$index]['message'] = 'TABLE EMPTY OR NO DATA';	
		}

		return $respon;
	}

    function fnDeleteItem($conn, $id, $nmTable){
        $index = 0;
        $SQLAdd =
            "DELETE FROM ".$nmTable." WHERE id = '".$id."'";

        if (mysqli_query($conn, $SQLAdd)) {
            $respon[$index]['result'] = "SUCCESS";
            $respon[$index]['message'] = 'SUCCESSFULLY DELETED';
        } else {
            $respon[$index]['result'] = "null";
            $respon[$index]['message'] = 'DELETE FAILED !';
        }
        
        return $respon;
    }

    function fnDeleteSubItem($conn, $id, $sub, $nmTable){
        $index = 0;
        $SQLAdd =
            "DELETE FROM ".$nmTable." WHERE ".$sub." = '".$id."'";

        if (mysqli_query($conn, $SQLAdd)) {
            $respon[$index]['result'] = "SUCCESS";
            $respon[$index]['message'] = 'SUCCESSFULLY DELETED';
        } else {
            $respon[$index]['result'] = "null";
            $respon[$index]['message'] = 'DELETE FAILED !';
        }
    }

    function fnDeleteItemWhere($conn, $nmTable, $isWhere){
        $index = 0;
        $SQLAdd =
            "DELETE FROM ".$nmTable." WHERE ".$isWhere."";

        if (mysqli_query($conn, $SQLAdd)) {
            $respon[$index]['result'] = "SUCCESS";
            $respon[$index]['message'] = 'SUCCESSFULLY DELETED';
        } else {
            $respon[$index]['result'] = "null";
            $respon[$index]['message'] = 'DELETE FAILED !';
        }
        
        return $respon;
    }

    function fnInsertItem($conn, $tbl, $kol, $val){
        $index = 0;
        #$val = fnExplode($val);

		$SQLAdd =
            "INSERT INTO ".$tbl." (".$kol.") VALUES (".$val.")";

        if (mysqli_query($conn, $SQLAdd)) {
            $respon[$index]['result'] = "SUCCESS";
            $respon[$index]['message'] = 'SUCCESSFULLY INSERTED';
        } else {
            $respon[$index]['result'] = "null";
            $respon[$index]['message'] = 'INPUT FAILED';
        }
		
		return $respon;
	}

    function fnInsertItemIsNull($conn, $tbl, $kol, $val, $isWhere){
		$index = 0;
        #$val = fnExplode($val);

		$SQLAdd = 
			"SELECT * FROM ".$tbl." WHERE ".$isWhere;
		$query = mysqli_query($conn, $SQLAdd);
		if (mysqli_num_rows($query) > 0){
			$respon[$index]['result'] = "null";
                        $respon[$index]['message'] = 'Already exist';
		} else {
			$SQLAdd =
                "INSERT INTO ".$tbl." (".$kol.") VALUES (".$val.")";

			if (mysqli_query($conn, $SQLAdd)) {
				$respon[$index]['result'] = "SUCCESS";
                $respon[$index]['message'] = 'Data Success Input';
			} else {
				$respon[$index]['result'] = "null";
                $respon[$index]['message'] = 'Sorry, Data Failed to Input';
                #$respon[$index]['SQL'] = $SQLAdd;
			}
		}
		
		return $respon;
	}

    function fnInsertItemIsNotNull($conn, $tbl, $kol, $val, $isWhere){
		$index = 0;
        #$val = fnExplode($val);

		$SQLAdd = 
			"SELECT * FROM ".$tbl." WHERE ".$isWhere;
		$query = mysqli_query($conn, $SQLAdd);
		if (mysqli_num_rows($query) == 0){
			$respon[$index]['result'] = "null";
            $respon[$index]['message'] = 'Already exist';
		} else {
			$SQLAdd =
                "INSERT INTO ".$tbl." (".$kol.") VALUES (".$val.")";

			if (mysqli_query($conn, $SQLAdd)) {
				$respon[$index]['result'] = "SUCCESS";
                $respon[$index]['message'] = 'SUCCESSFULLY INSERTED';
			} else {
				$respon[$index]['result'] = "null";
                $respon[$index]['message'] = 'INPUT FAILED';
			}
		}
		
		return $respon;
	}

    function fnUpdateItem($conn, $tbl, $val, $isWHere){
		$index = 0;

		$SQLAdd =
            "UPDATE ".$tbl." SET ".$val." WHERE ".$isWHere;

        if (mysqli_query($conn, $SQLAdd)) {
            $respon[$index]['result'] = "SUCCESS";
            $respon[$index]['message'] = 'SUCCESSFULLY UPDATED';
        } else {
            $respon[$index]['result'] = "null";
            $respon[$index]['message'] = 'UPDATE FAILED !';
        }
		
		return $respon;
	}

    function fnUpdateItemIsNull($conn, $tbl, $val, $id, $isWhere){
		$index = 0;

		$SQLAdd = 
			"SELECT * FROM ".$tbl." WHERE ".$isWhere." AND id NOT IN ('".$id."')";
		$query = mysqli_query($conn, $SQLAdd);
		if (mysqli_num_rows($query) > 0){
			$respon[$index]['result'] = "null";
            $respon[$index]['message'] = 'Already exist';
		} else {
			$SQLAdd =
                "UPDATE ".$tbl." SET ".$val." WHERE id = '".$id."'";

            #echo $SQLAdd;

			if (mysqli_query($conn, $SQLAdd)) {
				$respon[$index]['result'] = "SUCCESS";
                $respon[$index]['message'] = 'SUCCESSFULLY INSERTED';
			} else {
				$respon[$index]['result'] = "null";
                $respon[$index]['message'] = 'INPUT FAILED !';
			}
		}
		
		return $respon;
	}

    function fnUpdateItemIsNotNull($conn, $tbl, $val, $id, $isWhere){
		$index = 0;

		$SQLAdd = 
			"SELECT * FROM ".$tbl." WHERE ".$isWhere;
		$query = mysqli_query($conn, $SQLAdd);
		if (mysqli_num_rows($query) == 0){
			$respon[$index]['result'] = "null";
            $respon[$index]['message'] = 'Already exist';
		} else {
			$SQLAdd =
                "UPDATE ".$tbl." SET ".$val." WHERE id = '".$id."'";

			if (mysqli_query($conn, $SQLAdd)) {
				$respon[$index]['result'] = "SUCCESS";
                $respon[$index]['message'] = 'SUCCESSFULLY INSERTED';
			} else {
				$respon[$index]['result'] = "null";
                $respon[$index]['message'] = 'INPUT FAILED !';
			}
		}
		
		return $respon;
    }
    
	
?>