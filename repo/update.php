<?php
// session_start();
header('Content-Type: application/json');

if ($_SERVER['REQUEST_METHOD'] === "POST") {
    $json = file_get_contents('php://input');
    $data = json_decode($json);
    
    

    // // //id login nome email senha
    
    $id = $data->{'id'};
    
    
        // $conn = new PDO('mysql:host=localhost;dbname=id16412277_repo','id16412277_repositorio', '>vC?3FsWY+H#[<r0');
        // $stmt = $conn->prepare("");
        // $stmt->execute();
        
        
        //  header('Content-Type: application/json'); 
  
      $conn = new PDO('mysql:host=localhost;dbname=id16412277_repo','id16412277_repositorio', '>vC?3FsWY+H#[<r0');
      $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
  
      $data = $conn->prepare("SELECT * FROM id16412277_repo.trabalhos where id='$id'");
  
      $data->execute();

      $results = $data->fetchAll(PDO::FETCH_ASSOC);
      echo json_encode($results); 
  
    
   
    
      
     
 
    
 
} else {
    http_response_code(400);
    echo json_encode(array("message" => "invalid method request"));
}
//echo'e';

?>