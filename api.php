<?php
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Origin: *"); 
header("Access-Control-Allow-Methods: POST");

require 'db.php'; // veri tabanini ekliyoruz ki api veri tabanini kullansin

$rawData = file_get_contents("php://input");
$request = json_decode($rawData, true);

if (!$request) {
    echo json_encode(["status" => "error", "message" => "istek gecerli degil!"]);
    exit;
}

$appId = isset($request['appId']) ? $request['appId'] : null;
$os = isset($request['os']) ? $request['os'] : null;
// kullanici distroyu secmedigi zaman otomatik default secmesi icin alttaki satirlar ekledni
$distro = isset($request['distro']) ? $request['distro'] : 'default'; 

if (!$appId || !$os) {
    echo json_encode(["status" => "error", "message" => "eksik parametre"]);
    exit;
}

// databaseden pdo ile verileri cekiyoruz
$stmt = $db->prepare("SELECT command_text FROM commands WHERE app_id = ? AND os = ? AND distro = ?");
$stmt->execute([$appId, $os, $distro]);
$result = $stmt->fetch(PDO::FETCH_ASSOC);

if ($result) {
    echo json_encode([
        "status" => "success",
        "command" => $result['command_text']
    ]);
} else {
    echo json_encode([
        "status" => "error",
        "message" => "json islenemedi!"
    ]);
}
?>