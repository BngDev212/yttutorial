<?php
    include_once 'config/config.php';
    include_once 'config/function.php';
    include_once 'config/loadData.php';
	
	header("Content-Type: application/json; charset=UTF-8");

	$index = 0;
	$respon = array(); 

	if (empty($_GET['act'])) {
		$respon[$index]['result'] = 'null';
		$respon[$index]['message'] = 'No action';
	} else {
		if (!$connection) {
			$respon[$index]['result'] = 'null';
			$respon[$index]['message'] = 'Server connection failed, check server configuration';	
		} else {
			if ($_GET['act'] == 'deleteItem'){ 
				$respon = fnDeleteItem($connection, $_POST['id'], $_POST['tbl']);
			} elseif ($_GET['act'] == 'deleteItemWhere') {
				$respon = fnDeleteItemWhere($connection, $_POST['tbl'], $_POST['isWhere']);
			} elseif ($_GET['act'] == 'insertItem') {
				$respon = fnInsertItem($connection, $_POST['tbl'], $_POST['kol'], $_POST['val']);
			} elseif ($_GET['act'] == 'insertItemIsNull') {
				$respon = fnInsertItemIsNull($connection, $_POST['tbl'], $_POST['kol'], $_POST['val'], $_POST['isWhere']);
			} elseif ($_GET['act'] == 'insertItemIsNotNull') {
				$respon = fnInsertItemIsNotNull($connection, $_POST['tbl'], $_POST['kol'], $_POST['val'], $_POST['isWhere']);
			} elseif ($_GET['act'] == 'updateItem') {
				$respon = fnUpdateItem($connection, $_POST['tbl'], $_POST['val'], $_POST['isWhere']);	
			} elseif ($_GET['act'] == 'updateItemIsNull') {
				$respon = fnUpdateItemIsNull($connection, $_POST['tbl'], $_POST['val'], $_POST['id'], $_POST['isWhere']);
			} elseif ($_GET['act'] == 'updateItemIsNotNull') {
				$respon = fnUpdateItemIsNotNull($connection, $_POST['tbl'], $_POST['val'], $_POST['id'], $_POST['isWhere']);
			} elseif ($_GET['act'] == 'loadItem') {
				$respon = fnGetItem($connection, $_POST['tbl'], $_POST['val'], $_POST['isWhere'], $_POST['order'], $_POST['limit']);
			} else {
				$respon[$index]['result'] = "null";
				$respon[$index]['message'] = 'Invalid action';
			}
		}
	}
	
	echo json_encode($respon,JSON_PRETTY_PRINT);
?>