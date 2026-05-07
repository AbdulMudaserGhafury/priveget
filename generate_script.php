<?php
require 'db.php'; 

$rawData = file_get_contents("php://input");
$request = json_decode($rawData, true);

if (!$request || empty($request['apps'])) {
    echo json_encode(["status" => "error", "message" => "Hiç uygulama seçilmedi."]);
    exit;
}

$apps = $request['apps'];
$osSelection = $request['os']; 

if (strpos($osSelection, 'linux-') === 0) {
    $os = 'linux';
    $distro = str_replace('linux-', '', $osSelection);
} else {
    $os = $osSelection;
    $distro = 'default';
}

$placeholders = implode(',', array_fill(0, count($apps), '?'));
$sql = "SELECT app_id, command_text FROM commands WHERE os = ? AND distro = ? AND app_id IN ($placeholders)";

$stmt = $db->prepare($sql);
$params = array_merge([$os, $distro], $apps);
$stmt->execute($params);
$results = $stmt->fetchAll(PDO::FETCH_ASSOC);

$scriptContent = "";

if ($os === 'windows') {
    $scriptContent .= "@echo off\r\n";
    $scriptContent .= "echo ===================================\r\n";
    $scriptContent .= "echo PriveGet Toplu Kurulum Baslatiliyor\r\n";
    $scriptContent .= "echo ===================================\r\n\r\n";
    foreach ($results as $row) {
        $scriptContent .= "echo Kuruluyor: " . $row['app_id'] . "...\r\n";
        $scriptContent .= $row['command_text'] . "\r\n\r\n";
    }
    $scriptContent .= "echo Tum kurulumlar tamamlandi!\r\n";
    $scriptContent .= "pause";
} else {
    $scriptContent .= "#!/bin/bash\n\n";
    $scriptContent .= "echo \"===================================\"\n";
    $scriptContent .= "echo \"PriveGet Toplu Kurulum Baslatiliyor\"\n";
    $scriptContent .= "echo \"===================================\"\n\n";
    foreach ($results as $row) {
        $scriptContent .= "echo \"Kuruluyor: " . $row['app_id'] . "...\"\n";
        $scriptContent .= $row['command_text'] . "\n\n";
    }
    $scriptContent .= "echo \"Tum kurulumlar tamamlandi!\"";
}

// PHP'den JavaScript'e JSON olarak kodu gönderiyoruz
header('Content-Type: application/json');
echo json_encode(["status" => "success", "script" => $scriptContent]);
?>