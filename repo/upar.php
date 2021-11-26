<?php 

header('Content-Type: application/json');
$return["error"] = false;
$return["msg"] = "";
$return["success"] = false;
//array to return

$getPost = (json_encode(file_get_contents('php://input',true)));
$jsondecoded = utf8_encode($getPost);

echo(json_last_error());
var_dump($getPost);
var_dump($jsondecoded);

    // ini_set('display_errors', 1);
    // ini_set('display_startup_errors', 1);
    // error_reporting(E_ALL);
    // echo file_get_contents('php://input');
    // echo '<br>';
    // echo $_POST["curso"];



if(isset($_FILES["file"])){
    //directory to upload file
    $target_dir = "PDFs/"; //create folder files/ to save file
    $filename = $_FILES["file"]["name"]; 
    //name of file
    //$_FILES["file"]["size"] get the size of file
    //you can validate here extension and size to upload file.
    $cripto = md5($filename);
    //rename($filename,$cripto);
    $savefile = "$target_dir/$cripto";
    //complete path to save file

    if(move_uploaded_file($_FILES["file"]["tmp_name"], $savefile)) {
        $return["error"] = false;
        //upload successful
    }else{
        $return["error"] = true;
        $return["msg"] =  "Error during saving file.";
    }
}else{
    $return["error"] = true;
    $return["msg"] =  "No file is sublitted.";
}
   

// tell browser that its a json data
echo json_encode($return);
//converting array to JSON string
?>