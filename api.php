<?php
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Origin: *"); 
header("Access-Control-Allow-Methods: POST");

require 'db.php'; // Veritabanı bağlantısını dahil ettik

$rawData = file_get_contents("php://input");
$request = json_decode($rawData, true);

if (!$request) {
    echo json_encode(["status" => "error", "message" => "Geçersiz istek."]);
    exit;
}

$appId = isset($request['appId']) ? $request['appId'] : null;
$os = isset($request['os']) ? $request['os'] : null;
// Eğer distro seçilmemişse veya windows/macos ise varsayılan olarak 'default' kullan
$distro = isset($request['distro']) ? $request['distro'] : 'default'; 

if (!$appId || !$os) {
    echo json_encode(["status" => "error", "message" => "Eksik parametre."]);
    exit;
}

// Veritabanından (MySQL) komutu çekiyoruz (PDO Güvenliği ile)
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
        "message" => "Bu işletim sistemi/dağıtım için henüz komut eklenmemiş."
    ]);
}
?>