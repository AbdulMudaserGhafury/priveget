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

$commandsList = [];

foreach ($results as $row) {
    $commandsList[] = trim($row['command_text']);
}

$scriptContent = implode(' && ', $commandsList);

header('Content-Type: application/json');
echo json_encode(["status" => "success", "script" => $scriptContent]);
?>