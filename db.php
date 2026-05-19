<?php
$env=parse_ini_file(__DIR__.'/.env'); //.env dosyasini okuyoruz

$host = 'localhost';
$dbname = 'priveget_db'; 
$user = 'root';          
//$pass = $env['DATABASE_PASSWORD']; //database sifresini kullaniyoruz
$pass = 'suleyman45';

try {
    $db = new PDO("mysql:host=$host;dbname=$dbname;charset=utf8", $user, $pass);
    $db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch (PDOException $e) {
    die(json_encode(["status" => "error", "message" => "Veritabanı bağlantı hatası: " . $e->getMessage()]));
}
?>
