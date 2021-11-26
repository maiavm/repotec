<?php

header('Content-Type: application/json');

if ($_SERVER['REQUEST_METHOD'] === "POST") {
    $json = file_get_contents('php://input');
    $data = json_decode($json);
    $id = $data->{'id'};
    $desenvolvedor1 = $data->{'desenvolvedor1'};
    $desenvolvedor2 = $data->{'desenvolvedor2'};
    $desenvolvedor3 = $data->{'desenvolvedor3'};
    $curso = $data->{'curso'};
    $ciclo = $data->{'ciclo'};
    $titulo = $data->{'titulo'};
    $orientador = $data->{'orientador'};
    $resumo = $data->{'resumo'};
    
   
    $projeto = $data->{'projeto'};
    try {
        $conn = new PDO('mysql:localhost;dbname=id16412277_repo','id16412277_repositorio', '>vC?3FsWY+H#[<r0');
        $stmt = $conn->prepare("UPDATE id16412277_repo.trabalhos SET dev1=:dev1, dev2=:dev2, dev3=:dev3, curso=:curso, ciclo=:ciclo, titulo= :titulo, orientador=:orientador, descri=:resumo, projeto=:projeto WHERE id=:id ");
        $stmt->execute(array(":dev1" => $desenvolvedor1, ":dev2" => $desenvolvedor2, ":dev3" => $desenvolvedor3, ":curso" => $curso, ":ciclo" => $ciclo, ":titulo" => $titulo, ":orientador" => $orientador, ":resumo" => $resumo, ":id" => $id, ":projeto"=>$projeto));
    } catch (PDOException $e) {
        echo $e->getMessage();
    }
    
    if ($stmt->rowCount() > 0) {
        http_response_code(200);
        echo json_encode(array("message" => "OK"));
    } else {
        http_response_code(400);
        echo json_encode(array("message" => "FAIL"));
    }
} else {
    http_response_code(400);
    echo json_encode(array("message" => "invalid method request"));
}

    
   
?>