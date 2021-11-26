<?php
// session_start();
header('Content-Type: application/json');

if ($_SERVER['REQUEST_METHOD'] === "POST") {
    $json = file_get_contents('php://input');
    $data = json_decode($json);
    
    

    // //id login nome email senha
    
     // $id = $data->{'id'};
    $login = $data->{'login'};
    // $nome = $data->{'nome'};
    // $email = $data->{'email'};
    $senha = $data->{'senha'};
    
    $senhaCripto = md5($senha);
   
//   echo json_encode(" o login é: ". $login. " a senha: ". $senhaCripto);
    $conn = new PDO('mysql:host=localhost;dbname=id16412277_repo','id16412277_repositorio', '>vC?3FsWY+H#[<r0');
    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
      
   
      
  
      
        $stmt = $conn->prepare("SELECT login, senha FROM id16412277_repo.administracao where login='$login' and senha='$senhaCripto'");
        $stmt->execute();
      
     

      $results = $stmt->fetchAll(PDO::FETCH_ASSOC);
      //echo json_encode($results);
      
      if($results == null){
          echo(json_encode('0'));
      }else{
          echo(json_encode('1'));
      }
      
      
      
   
    
    
    
    
    
 
} else {
    http_response_code(400);
    echo json_encode(array("message" => "invalid method request"));
}


?>