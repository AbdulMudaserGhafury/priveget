<?php
$env=@parse_ini_file(__DIR__.'/.env'); //.env dosyasini okuyoruz

$host = isset($env['HOST_NAME']) ? $env['HOST_NAME'] : (getenv('HOST_NAME') ?: 'db');

$databaseIsmi = 'priveget_db'; 
$user = 'root';          
$sifre = $env['DATABASE_PASSWORD'];

try {
    $db = new PDO("mysql:host=$host;dbname=$databaseIsmi;charset=utf8", $user, $sifre);
    $db->setAttribute(PDO::ATTR_TIMEOUT, 4);
    $db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch (PDOException $e) {
    die(json_encode(["status" => "error", "message" => "Bağlantı hatası: " . $e->getMessage()]));
}
?>
