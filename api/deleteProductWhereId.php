<?php
	include 'connected.php';
	header("Access-Control-Allow-Origin: *");
	error_reporting(E_ERROR | E_PARSE);

if (!$link) {
    echo "Error: Unable to connect to MySQL." . PHP_EOL;
    echo "Debugging errno: " . mysqli_connect_errno() . PHP_EOL;
    echo "Debugging error: " . mysqli_connect_error() . PHP_EOL;
    
    exit;
}else {

	if (isset($_GET)) {
	if ($_GET['isAdd'] == 'true') {
			
		$id = $_GET['id'];

		$sql_select = "SELECT * FROM product WHERE id = '$id'";
		$result = mysqli_query($link, $sql_select);
		$row = mysqli_fetch_array($result);				
    		$image = $row['images'];
    		$images_sub1 = substr($image,1);
    		$images_sub2 = substr($images_sub1,0,-1);
    		$images = explode(', ', $images_sub2);
    		$count = count($images);   		
    		
    	for($i = 0; $i < $count; $i++){
    		$path = "img/products/".$images[$i];
    			@unlink($path);
    			echo $path;
		}
									
		$sql = "DELETE FROM product WHERE id = '$id'";
		$result = mysqli_query($link, $sql);

		if ($result) {
			echo "True";
		} else {
			echo "False";
		}

	} else echo "Welcome To Chanyont";
   
}
	
}
	mysqli_close($link);
?>