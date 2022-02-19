<?php
error_reporting(E_ERROR | E_PARSE);

// Response object structure
$response = new stdClass;
$response->status = null;
$response->message = null;

// Uploading file
$destination_dir = "img/products/";
$base_filename = basename($_FILES["file"]["name"]);
$target_file = $destination_dir . $base_filename;

if(isset($_GET['oldImages'])){
	$oldImages = $_GET['oldImages'];
    $path = "img/products/".$oldImages;
    @unlink($path);
}

if(!$_FILES["file"]["error"])
{
    if (move_uploaded_file($_FILES["file"]["tmp_name"], $target_file)) {        
        $response->status = true;
        $response->message = "File uploaded successfully";

    } else {

        $response->status = false;
        $response->message = "File uploading failed";
    }    
} 
else
{
    $response->status = false;
    $response->message = "File uploading failed";
}

header('Content-Type: application/json');
echo json_encode($response);