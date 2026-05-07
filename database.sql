-- PriveGet Projesi MySQL Veritabanı Kurulum Dosyası
-- Geliştiriciler: Mudaser Azizyar & Suleyman Suleymanov

-- 1. Veritabanını oluştur (Eğer daha önce kurulmamışsa) ve UTF-8 dil desteğini ekle
CREATE DATABASE IF NOT EXISTS priveget_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- 2. Tabloları bu veritabanının içine kuracağımızı belirt
USE priveget_db;

-- 3. Eğer commands tablosu zaten varsa sil (Çakışmaları önlemek ve temiz kurulum yapmak için)
DROP TABLE IF EXISTS commands;

-- 4. Komutların tutulacağı ana tabloyu oluştur
CREATE TABLE commands (
    id INT AUTO_INCREMENT PRIMARY KEY,
    app_id VARCHAR(50) NOT NULL,
    os VARCHAR(20) NOT NULL,
    distro VARCHAR(20) DEFAULT 'default',
    command_text TEXT NOT NULL
);

-- ==========================================
-- 5. UYGULAMA KOMUTLARINI SİSTEME EKLEME
-- ==========================================

-- LibreWolf Verileri
INSERT INTO commands (app_id, os, distro, command_text) VALUES 
('librewolf', 'windows', 'default', 'winget install LibreWolf.LibreWolf'),
('librewolf', 'macos', 'default', 'brew install --cask librewolf'),
('librewolf', 'linux', 'apt', 'sudo apt update && sudo apt install librewolf -y'),
('librewolf', 'linux', 'pacman', 'yay -S librewolf-bin'),
('librewolf', 'linux', 'dnf', 'sudo dnf install librewolf');

-- Firefox Browser Verileri
INSERT INTO commands (app_id, os, distro, command_text) VALUES 
('firefox-browser', 'windows', 'default', 'winget install Mozilla.Firefox'),
('firefox-browser', 'macos', 'default', 'brew install --cask firefox'),
('firefox-browser', 'linux', 'apt', 'sudo apt update && sudo apt install firefox-browser -y'),
('firefox-browser', 'linux', 'pacman', 'sudo pacman -S firefox'),
('firefox-browser', 'linux', 'dnf', 'sudo dnf install firefox');

-- Mullvad Browser Verileri
INSERT INTO commands (app_id, os, distro, command_text) VALUES 
('mullvad', 'windows', 'default', 'winget install Mullvad.MullvadBrowser'),
('mullvad', 'macos', 'default', 'brew install --cask mullvad-browser'),
('mullvad', 'linux', 'apt', 'sudo apt install mullvad-browser -y'),
('mullvad', 'linux', 'pacman', 'yay -S mullvad-browser-bin'),
('mullvad', 'linux', 'dnf', 'sudo dnf install mullvad-browser');

-- Signal Messenger Verileri
INSERT INTO commands (app_id, os, distro, command_text) VALUES 
('signal', 'windows', 'default', 'winget install OpenWhisperSystems.Signal'),
('signal', 'macos', 'default', 'brew install --cask signal'),
('signal', 'linux', 'apt', 'sudo apt update && sudo apt install signal-desktop -y'),
('signal', 'linux', 'pacman', 'sudo pacman -S signal-desktop'),
('signal', 'linux', 'dnf', 'sudo dnf install signal-desktop');

-- Mozilla Thunderbird Verileri
INSERT INTO commands (app_id, os, distro, command_text) VALUES 
('thunderbird', 'windows', 'default', 'winget install Mozilla.Thunderbird'),
('thunderbird', 'macos', 'default', 'brew install --cask thunderbird'),
('thunderbird', 'linux', 'apt', 'sudo apt install thunderbird -y'),
('thunderbird', 'linux', 'pacman', 'sudo pacman -S thunderbird'),
('thunderbird', 'linux', 'dnf', 'sudo dnf install thunderbird');

-- Bitwarden Verileri
INSERT INTO commands (app_id, os, distro, command_text) VALUES 
('bitwarden', 'windows', 'default', 'winget install Bitwarden.Bitwarden'),
('bitwarden', 'macos', 'default', 'brew install --cask bitwarden'),
('bitwarden', 'linux', 'apt', 'sudo snap install bitwarden'),
('bitwarden', 'linux', 'pacman', 'sudo pacman -S bitwarden'),
('bitwarden', 'linux', 'dnf', 'sudo snap install bitwarden');

-- KeePassXC Verileri
INSERT INTO commands (app_id, os, distro, command_text) VALUES 
('keepassxc', 'windows', 'default', 'winget install KeePassXCTeam.KeePassXC'),
('keepassxc', 'macos', 'default', 'brew install --cask keepassxc'),
('keepassxc', 'linux', 'apt', 'sudo apt install keepassxc -y'),
('keepassxc', 'linux', 'pacman', 'sudo pacman -S keepassxc'),
('keepassxc', 'linux', 'dnf', 'sudo dnf install keepassxc');

-- BleachBit Verileri
INSERT INTO commands (app_id, os, distro, command_text) VALUES 
('bleachbit', 'windows', 'default', 'winget install BleachBit.BleachBit'),
('bleachbit', 'macos', 'default', 'brew install --cask bleachbit'),
('bleachbit', 'linux', 'apt', 'sudo apt install bleachbit -y'),
('bleachbit', 'linux', 'pacman', 'sudo pacman -S bleachbit'),
('bleachbit', 'linux', 'dnf', 'sudo dnf install bleachbit');

-- Syncthing Verileri
INSERT INTO commands (app_id, os, distro, command_text) VALUES 
('syncthing', 'windows', 'default', 'winget install Syncthing.Syncthing'),
('syncthing', 'macos', 'default', 'brew install --cask syncthing'),
('syncthing', 'linux', 'apt', 'sudo apt install syncthing -y'),
('syncthing', 'linux', 'pacman', 'sudo pacman -S syncthing'),
('syncthing', 'linux', 'dnf', 'sudo dnf install syncthing');

-- Kurulum tamamlandı uyarısı
SELECT 'PriveGet Veritabani Basariyla Kuruldu!' AS Bilgi;