CREATE DATABASE IF NOT EXISTS priveget_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE priveget_db;

DROP TABLE IF EXISTS commands;
DROP TABLE IF EXISTS apps;

-- 1. Uygulama bilgilerini tutan ana tablo
CREATE TABLE apps (
    app_id VARCHAR(50) PRIMARY KEY,
    app_name VARCHAR(100) NOT NULL,
    app_desc TEXT NOT NULL,
    category VARCHAR(50) NOT NULL
);

-- 2. Komutları tutan ve ana tabloya bağlanan tablo
CREATE TABLE commands (
    id INT AUTO_INCREMENT PRIMARY KEY,
    app_id VARCHAR(50) NOT NULL,
    os VARCHAR(20) NOT NULL,
    distro VARCHAR(20) DEFAULT 'default',
    command_text TEXT NOT NULL,
    FOREIGN KEY (app_id) REFERENCES apps(app_id) ON DELETE CASCADE
);

-- Örnek Uygulama Verileri
INSERT INTO apps (app_id, app_name, app_desc, category) VALUES
('librewolf', 'LibreWolf', 'Gizlilik odaklı, telemetri içermeyen hızlı web tarayıcısı.', 'browsers'),
('firefox-browser', 'Firefox Browser', 'Açık kaynaklı, özelleştirilebilir internet tarayıcısı.', 'browsers'),
('mullvad', 'Mullvad Browser', 'Tor ağı entegrasyonlu, parmak izi bırakmayan tarayıcı.', 'browsers'),
('signal', 'Signal Messenger', 'Uçtan uca şifreli, açık kaynaklı anlık mesajlaşma.', 'communication'),
('thunderbird', 'Mozilla Thunderbird', 'Gelişmiş PGP şifreleme destekli güvenli e-posta istemcisi.', 'communication'),
('bitwarden', 'Bitwarden', 'Bulut senkronizasyonlu, tamamen açık kaynaklı parola yöneticisi.', 'passwords'),
('keepassxc', 'KeePassXC', 'Verileri sadece bilgisayarınızda tutan çevrimdışı parola kasası.', 'passwords'),
('bleachbit', 'BleachBit', 'Dijital ayak izlerini silen ve dosyaları kalıcı olarak yok eden araç.', 'security'),
('syncthing', 'Syncthing', 'Merkezi sunucu kullanmadan şifreli dosya senkronizasyonu.', 'security');

-- Örnek Komut Verileri (Aynen aktarıldı)
INSERT INTO commands (app_id, os, distro, command_text) VALUES 
('librewolf', 'windows', 'default', 'winget install LibreWolf.LibreWolf'),
('librewolf', 'macos', 'default', 'brew install --cask librewolf'),
('librewolf', 'linux', 'apt', 'sudo apt update && sudo apt install librewolf -y'),
('librewolf', 'linux', 'pacman', 'yay -S librewolf-bin'),
('librewolf', 'linux', 'dnf', 'sudo dnf install librewolf'),
('firefox-browser', 'windows', 'default', 'winget install Mozilla.Firefox'),
('firefox-browser', 'macos', 'default', 'brew install --cask firefox'),
('firefox-browser', 'linux', 'apt', 'sudo apt update && sudo apt install firefox-browser -y'),
('firefox-browser', 'linux', 'pacman', 'sudo pacman -S firefox'),
('firefox-browser', 'linux', 'dnf', 'sudo dnf install firefox'),
('mullvad', 'windows', 'default', 'winget install Mullvad.MullvadBrowser'),
('mullvad', 'macos', 'default', 'brew install --cask mullvad-browser'),
('mullvad', 'linux', 'apt', 'sudo apt install mullvad-browser -y'),
('mullvad', 'linux', 'pacman', 'yay -S mullvad-browser-bin'),
('mullvad', 'linux', 'dnf', 'sudo dnf install mullvad-browser'),
('signal', 'windows', 'default', 'winget install OpenWhisperSystems.Signal'),
('signal', 'macos', 'default', 'brew install --cask signal'),
('signal', 'linux', 'apt', 'sudo apt update && sudo apt install signal-desktop -y'),
('signal', 'linux', 'pacman', 'sudo pacman -S signal-desktop'),
('signal', 'linux', 'dnf', 'sudo dnf install signal-desktop'),
('thunderbird', 'windows', 'default', 'winget install Mozilla.Thunderbird'),
('thunderbird', 'macos', 'default', 'brew install --cask thunderbird'),
('thunderbird', 'linux', 'apt', 'sudo apt install thunderbird -y'),
('thunderbird', 'linux', 'pacman', 'sudo pacman -S thunderbird'),
('thunderbird', 'linux', 'dnf', 'sudo dnf install thunderbird'),
('bitwarden', 'windows', 'default', 'winget install Bitwarden.Bitwarden'),
('bitwarden', 'macos', 'default', 'brew install --cask bitwarden'),
('bitwarden', 'linux', 'apt', 'sudo snap install bitwarden'),
('bitwarden', 'linux', 'pacman', 'sudo pacman -S bitwarden'),
('bitwarden', 'linux', 'dnf', 'sudo snap install bitwarden'),
('keepassxc', 'windows', 'default', 'winget install KeePassXCTeam.KeePassXC'),
('keepassxc', 'macos', 'default', 'brew install --cask keepassxc'),
('keepassxc', 'linux', 'apt', 'sudo apt install keepassxc -y'),
('keepassxc', 'linux', 'pacman', 'sudo pacman -S keepassxc'),
('keepassxc', 'linux', 'dnf', 'sudo dnf install keepassxc'),
('bleachbit', 'windows', 'default', 'winget install BleachBit.BleachBit'),
('bleachbit', 'macos', 'default', 'brew install --cask bleachbit'),
('bleachbit', 'linux', 'apt', 'sudo apt install bleachbit -y'),
('bleachbit', 'linux', 'pacman', 'sudo pacman -S bleachbit'),
('bleachbit', 'linux', 'dnf', 'sudo dnf install bleachbit'),
('syncthing', 'windows', 'default', 'winget install Syncthing.Syncthing'),
('syncthing', 'macos', 'default', 'brew install --cask syncthing'),
('syncthing', 'linux', 'apt', 'sudo apt install syncthing -y'),
('syncthing', 'linux', 'pacman', 'sudo pacman -S syncthing'),
('syncthing', 'linux', 'dnf', 'sudo dnf install syncthing');