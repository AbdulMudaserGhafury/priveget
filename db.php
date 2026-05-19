<?php
$env=@parse_ini_file(__DIR__.'/.env'); //.env dosyasini okuyoruz

$host = isset($env['HOST_NAME']) ? $env['HOST_NAME'] : (getenv('HOST_NAME') ?: 'db');

$dbname = 'priveget_db'; 
$user = 'root';          
$pass = isset($env['DATABASE_PASSWORD']) ? $env['DATABASE_PASSWORD'] : (getenv('DATABASE_PASSWORD') ?: '');

try {
    $db = new PDO("mysql:host=$host;dbname=$dbname;charset=utf8", $user, $pass);
    $db->setAttribute(PDO::ATTR_TIMEOUT, 3);
    $db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch (PDOException $e) {
    die(json_encode(["status" => "error", "message" => "Veritabanı bağlantı hatası: " . $e->getMessage()]));
}
?>
