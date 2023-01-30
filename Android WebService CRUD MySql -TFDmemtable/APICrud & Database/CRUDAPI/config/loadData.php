<?php
    include_once 'function.php';
	
    function fnLoadInfo($conn){
		$index = 0;
		
		$SQLAdd =
			"SELECT * FROM tbl_data";

		$query = mysqli_query($conn, $SQLAdd);

		if (mysqli_num_rows($query) > 0){
			while ($list = mysqli_fetch_assoc($query)) {
				$respon[] = $list;
			}
		} else {
			$respon[$index]['result'] = 'null';	
			$respon[$index]['message'] = 'NO DATA FOUND !';	
		}

		return $respon;
	}
	
    
?>