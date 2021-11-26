<?php



// $link = mysqli_connect('localhost:3306', 'root', '', 'repo');
// if($link->connect_error){
//    echo "Desconectado! Erro: " . $link->connect_error;
// }else{
//    echo "Conectado!<br>";
// }
/*



*/
      header('Content-Type: application/json'); 
      //header("Access-Control-Allow-Origin: *");
  
      $conn = new PDO('mysql:host=localhost;dbname=id16412277_repo','id16412277_repositorio', '>vC?3FsWY+H#[<r0');
      $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
  
      $data = $conn->prepare('SELECT * FROM trabalhos');
  
      $data->execute();

      $results = $data->fetchAll(PDO::FETCH_ASSOC);
      echo json_encode($results);

      // $sql = "select * from trabalhos";
      // $result = mysqli_query($link, $sql) or die("Error in Selecting " . mysqli_error($connection));

      // $emparray = array();
      // while($row =mysqli_fetch_assoc($result))
      // {
      //   $emparray[] = $row;
      // }
      //  echo json_encode($emparray);

    
     /* $con=mysqli_connect('localhost','root','','repo');
      if (mysqli_connect_errno())
      {
      echo "Connection Error" . mysqli_connect_error();
      }
      $query = "SELECT * FROM trabalhos";
      $result = mysqli_query($con,$query);
      $querydata = array();

      while($data = mysqli_fetch_array($result)) {
      	$querydata[] = $data;
      }
      echo json_encode($querydata);   
      mysqli_close($con);*/
      ?>


