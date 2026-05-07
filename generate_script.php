<?php
require 'db.php'; // Veritabanı bağlantımız

$rawData = file_get_contents("php://input");
$request = json_decode($rawData, true);

if (!$request || empty($request['apps'])) {
    http_response_code(400);
    exit;
}

$apps = $request['apps'];
$osSelection = $request['os']; // Örn: windows, linux-apt, macos

// OS ve Distro ayrıştırması
if (strpos($osSelection, 'linux-') === 0) {
    $os = 'linux';
    $distro = str_replace('linux-', '', $osSelection);
} else {
    $os = $osSelection;
    $distro = 'default';
}

// Güvenli PDO sorgusu için array kadar soru işareti (?,?,?) oluşturuyoruz
$placeholders = implode(',', array_fill(0, count($apps), '?'));
$sql = "SELECT app_id, command_text FROM commands WHERE os = ? AND distro = ? AND app_id IN ($placeholders)";

$stmt = $db->prepare($sql);
$params = array_merge([$os, $distro], $apps);
$stmt->execute($params);
$results = $stmt->fetchAll(PDO::FETCH_ASSOC);

$scriptContent = "";

if ($os === 'windows') {
    // Windows Batch Script (.bat) formatı
    $scriptContent .= "@echo off\r\n";
    $scriptContent .= "echo ===================================\r\n";
    $scriptContent .= "echo PriveGet Toplu Kurulum Baslatiliyor\r\n";
    $scriptContent .= "echo ===================================\r\n\r\n";
    foreach ($results as $row) {
        $scriptContent .= "echo Kuruluyor: " . $row['app_id'] . "...\r\n";
        $scriptContent .= $row['command_text'] . "\r\n\r\n";
    }
    $scriptContent .= "echo Tum kurulumlar tamamlandi!\r\n";
    $scriptContent .= "pause\r\n";
    $ext = "bat";
    $mime = "application/x-bat";
} else {
    // Linux / macOS Bash Script (.sh) formatı
    $scriptContent .= "#!/bin/bash\n\n";
    $scriptContent .= "echo \"===================================\"\n";
    $scriptContent .= "echo \"PriveGet Toplu Kurulum Baslatiliyor\"\n";
    $scriptContent .= "echo \"===================================\"\n\n";
    foreach ($results as $row) {
        $scriptContent .= "echo \"Kuruluyor: " . $row['app_id'] . "...\"\n";
        $scriptContent .= $row['command_text'] . "\n\n";
    }
    $scriptContent .= "echo \"Tum kurulumlar tamamlandi!\"\n";
    $ext = "sh";
    $mime = "application/x-sh";
}

// Dosyayı indirtmek için tarayıcıya başlıkları (headers) gönderiyoruz
header("Content-Type: $mime");
header("Content-Disposition: attachment; filename=\"priveget_kurulum.$ext\"");
header("Content-Length: " . strlen($scriptContent));

echo $scriptContent;
?>