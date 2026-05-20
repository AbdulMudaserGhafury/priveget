<?php
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Origin: *");

require 'db.php';
//try catch ile islem basarisiz olursa diye fallback ekliyoruz
try {
    $stmt = $db->query("SELECT app_id, app_name, app_desc, category FROM apps");
    $apps = $stmt->fetchAll(PDO::FETCH_ASSOC);
    echo json_encode(["status" => "success", "data" => $apps]);
} catch (PDOException $e) {
    echo json_encode(["status" => "error", "message" => $e->getMessage()]);
}
?>