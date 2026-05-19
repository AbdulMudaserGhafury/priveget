USE priveget_db;

-- 1. UYGULAMA BİLGİLERİNİ EKLEME (30 Yeni Uygulama)
INSERT INTO apps (app_id, app_name, app_desc, category) VALUES
-- Tarayıcılar (Browsers)
('brave', 'Brave', 'Yerleşik reklam engelleyiciye sahip, Chromium tabanlı hızlı tarayıcı.', 'browsers'),
('tor-browser', 'Tor Browser', 'Tor ağı üzerinden trafiğinizi yönlendiren, maksimum anonimlik sağlayan tarayıcı.', 'browsers'),
('ungoogled-chromium', 'Ungoogled Chromium', 'Google servislerinden ve telemetriden tamamen arındırılmış Chromium sürümü.', 'browsers'),
-- İletişim (Communication)
('element', 'Element', 'Matrix protokolünü kullanan merkeziyetsiz, uçtan uca şifreli mesajlaşma aracı.', 'communication'),
('session', 'Session', 'Telefon numarası gerektirmeyen, blokzincir tabanlı ve soğan yönlendirmeli mesajlaşma.', 'communication'),
('wire', 'Wire', 'Açık kaynaklı, kurumlar ve bireyler için uçtan uca şifreli iletişim çözümü.', 'communication'),
('jami', 'Jami', 'Sunucusuz (P2P) çalışan, gizlilik odaklı sesli ve görüntülü sohbet uygulaması.', 'communication'),
('qtox', 'qTox', 'Merkezi bir sunucuya ihtiyaç duymayan eşler arası (P2P) güvenli mesajlaşma aracı.', 'communication'),
-- Takvim ve E-Posta (Calendar & Mail)
('tuta', 'Tuta', 'Tamamen açık kaynaklı ve uçtan uca şifreli e-posta ve takvim servisi.', 'calendar_mail'),
('proton-mail-bridge', 'Proton Mail Bridge', 'Proton Mail hesabınızı yerel masaüstü e-posta istemcileriyle kullanmanızı sağlar.', 'calendar_mail'),
('mailspring', 'Mailspring', 'Hızlı, genişletilebilir ve gizlilik dostu açık kaynaklı e-posta istemcisi.', 'calendar_mail'),
-- Bulut ve Senkronizasyon (Cloud)
('nextcloud-desktop', 'Nextcloud Desktop', 'Kendi sunucunuzda barındırdığınız bulut ortamı için dosya senkronizasyon istemcisi.', 'cloud'),
-- Ofis ve Notlar (Office)
('libreoffice', 'LibreOffice', 'Microsoft Office alternatifleri arasında en güçlü açık kaynaklı ve ücretsiz ofis paketi.', 'office'),
('onlyoffice', 'OnlyOffice Desktop', 'MS Office formatlarıyla üstün uyumluluk sunan gizlilik odaklı ofis yazılımı.', 'office'),
('obsidian', 'Obsidian', 'Verilerinizin tamamen kendi bilgisayarınızda kaldığı güçlü, Markdown tabanlı not alma aracı.', 'office'),
('joplin', 'Joplin', 'Uçtan uca şifreleme destekli, açık kaynaklı not alma ve yapılacaklar uygulaması.', 'office'),
('standard-notes', 'Standard Notes', 'Tamamen şifrelenmiş, minimalist ve platformlar arası senkronize not defteri.', 'office'),
('logseq', 'Logseq', 'Gizlilik odaklı, yerel çalışan, anahat (outline) tabanlı kişisel bilgi yönetimi aracı.', 'office'),
-- Veri Güvenliği (Security)
('cryptomator', 'Cryptomator', 'Bulut depolama (Nextcloud, Google Drive vb.) için istemci tarafı dosya şifreleme aracı.', 'security'),
('veracrypt', 'VeraCrypt', 'Açık kaynaklı, tüm diski veya belirli bölümleri şifreleyebilen güçlü güvenlik yazılımı.', 'security'),
('gnupg', 'GnuPG', 'Açık PGP standardının özgür bir uygulaması olan komut satırı şifreleme aracı.', 'security'),
('protonvpn', 'ProtonVPN', 'Kayıt tutmayan, İsviçre merkezli ve açık kaynak kodlu güvenli VPN istemcisi.', 'security'),
-- Parola Yöneticileri (Passwords)
('ente-auth', 'Ente Auth', 'Açık kaynaklı, bulut yedeklemeli ve uçtan uca şifreli 2FA (Çift Faktörlü) kimlik doğrulayıcı.', 'passwords'),
('yubico-authenticator', 'Yubico Authenticator', 'YubiKey donanım güvenlik anahtarları için masaüstü kimlik doğrulayıcı uygulaması.', 'passwords'),
-- Medya Araçları (Media)
('vlc', 'VLC Media Player', 'Telemetri içermeyen, hemen her formatı oynatabilen özgür medya oynatıcı.', 'media'),
('freetube', 'FreeTube', 'Aboneliklerinizi yerel tutan, reklamsız, gizlilik odaklı açık kaynak YouTube istemcisi.', 'media'),
('obs-studio', 'OBS Studio', 'Açık kaynaklı, profesyonel video kayıt ve canlı yayın yazılımı.', 'media'),
-- Geliştirici Araçları (Development)
('vscodium', 'VSCodium', 'Microsoft\'un telemetri ve izleme araçlarından arındırılmış VS Code sürümü.', 'development'),
('neovim', 'Neovim', 'Modern, yüksek düzeyde yapılandırılabilir ve genişletilebilir terminal tabanlı metin editörü.', 'development'),
-- Araçlar (Utilities)
('peazip', 'PeaZip', 'Dosya arşivleme ve arşiv şifreleme için WinRAR\'a açık kaynaklı güçlü bir alternatif.', 'utilities');

-- 2. UYGULAMA KOMUTLARINI EKLEME (150 Komut)
INSERT INTO commands (app_id, os, distro, command_text) VALUES 
-- Brave
('brave', 'windows', 'default', 'winget install Brave.Brave'),
('brave', 'macos', 'default', 'brew install --cask brave-browser'),
('brave', 'linux', 'apt', 'sudo apt install brave-browser -y'),
('brave', 'linux', 'pacman', 'yay -S brave-bin'),
('brave', 'linux', 'dnf', 'sudo dnf install brave-browser'),
-- Tor Browser
('tor-browser', 'windows', 'default', 'winget install TorProject.TorBrowser'),
('tor-browser', 'macos', 'default', 'brew install --cask tor-browser'),
('tor-browser', 'linux', 'apt', 'sudo apt install torbrowser-launcher -y'),
('tor-browser', 'linux', 'pacman', 'sudo pacman -S torbrowser-launcher'),
('tor-browser', 'linux', 'dnf', 'sudo dnf install torbrowser-launcher'),
-- Ungoogled Chromium
('ungoogled-chromium', 'windows', 'default', 'winget install eloston.ungoogled-chromium'),
('ungoogled-chromium', 'macos', 'default', 'brew install --cask eloston-ungoogled-chromium'),
('ungoogled-chromium', 'linux', 'apt', 'flatpak install flathub com.github.Eloston.UngoogledChromium'),
('ungoogled-chromium', 'linux', 'pacman', 'yay -S ungoogled-chromium'),
('ungoogled-chromium', 'linux', 'dnf', 'flatpak install flathub com.github.Eloston.UngoogledChromium'),
-- Element
('element', 'windows', 'default', 'winget install Element.Element'),
('element', 'macos', 'default', 'brew install --cask element'),
('element', 'linux', 'apt', 'sudo apt install element-desktop -y'),
('element', 'linux', 'pacman', 'sudo pacman -S element-desktop'),
('element', 'linux', 'dnf', 'sudo dnf install element-desktop'),
-- Session
('session', 'windows', 'default', 'winget install Session.Session'),
('session', 'macos', 'default', 'brew install --cask session'),
('session', 'linux', 'apt', 'flatpak install flathub network.loki.Session'),
('session', 'linux', 'pacman', 'yay -S session-desktop-bin'),
('session', 'linux', 'dnf', 'flatpak install flathub network.loki.Session'),
-- Wire
('wire', 'windows', 'default', 'winget install Wire.Wire'),
('wire', 'macos', 'default', 'brew install --cask wire'),
('wire', 'linux', 'apt', 'sudo apt install wire-desktop -y'),
('wire', 'linux', 'pacman', 'yay -S wire-desktop'),
('wire', 'linux', 'dnf', 'sudo dnf install wire-desktop'),
-- Jami
('jami', 'windows', 'default', 'winget install Savoir-faireLinux.Jami'),
('jami', 'macos', 'default', 'brew install --cask jami'),
('jami', 'linux', 'apt', 'sudo apt install jami -y'),
('jami', 'linux', 'pacman', 'sudo pacman -S jami'),
('jami', 'linux', 'dnf', 'sudo dnf install jami'),
-- qTox
('qtox', 'windows', 'default', 'winget install qTox.qTox'),
('qtox', 'macos', 'default', 'brew install --cask qtox'),
('qtox', 'linux', 'apt', 'sudo apt install qtox -y'),
('qtox', 'linux', 'pacman', 'sudo pacman -S qtox'),
('qtox', 'linux', 'dnf', 'sudo dnf install qtox'),
-- Tuta
('tuta', 'windows', 'default', 'winget install Tutanota.Tutanota'),
('tuta', 'macos', 'default', 'brew install --cask tutanota'),
('tuta', 'linux', 'apt', 'flatpak install flathub com.tutanota.Tutanota'),
('tuta', 'linux', 'pacman', 'yay -S tutanota-desktop'),
('tuta', 'linux', 'dnf', 'flatpak install flathub com.tutanota.Tutanota'),
-- Proton Mail Bridge
('proton-mail-bridge', 'windows', 'default', 'winget install Proton.ProtonMailBridge'),
('proton-mail-bridge', 'macos', 'default', 'brew install --cask protonmail-bridge'),
('proton-mail-bridge', 'linux', 'apt', 'sudo apt install protonmail-bridge -y'),
('proton-mail-bridge', 'linux', 'pacman', 'yay -S protonmail-bridge'),
('proton-mail-bridge', 'linux', 'dnf', 'sudo dnf install protonmail-bridge'),
-- Mailspring
('mailspring', 'windows', 'default', 'winget install Mailspring.Mailspring'),
('mailspring', 'macos', 'default', 'brew install --cask mailspring'),
('mailspring', 'linux', 'apt', 'sudo snap install mailspring'),
('mailspring', 'linux', 'pacman', 'yay -S mailspring'),
('mailspring', 'linux', 'dnf', 'sudo snap install mailspring'),
-- Nextcloud Desktop
('nextcloud-desktop', 'windows', 'default', 'winget install Nextcloud.NextcloudDesktop'),
('nextcloud-desktop', 'macos', 'default', 'brew install --cask nextcloud'),
('nextcloud-desktop', 'linux', 'apt', 'sudo apt install nextcloud-desktop -y'),
('nextcloud-desktop', 'linux', 'pacman', 'sudo pacman -S nextcloud-client'),
('nextcloud-desktop', 'linux', 'dnf', 'sudo dnf install nextcloud-client'),
-- LibreOffice
('libreoffice', 'windows', 'default', 'winget install TheDocumentFoundation.LibreOffice'),
('libreoffice', 'macos', 'default', 'brew install --cask libreoffice'),
('libreoffice', 'linux', 'apt', 'sudo apt install libreoffice -y'),
('libreoffice', 'linux', 'pacman', 'sudo pacman -S libreoffice-fresh'),
('libreoffice', 'linux', 'dnf', 'sudo dnf install libreoffice'),
-- OnlyOffice
('onlyoffice', 'windows', 'default', 'winget install ONLYOFFICE.DesktopEditors'),
('onlyoffice', 'macos', 'default', 'brew install --cask onlyoffice'),
('onlyoffice', 'linux', 'apt', 'sudo apt install onlyoffice-desktopeditors -y'),
('onlyoffice', 'linux', 'pacman', 'yay -S onlyoffice-bin'),
('onlyoffice', 'linux', 'dnf', 'sudo dnf install onlyoffice-desktopeditors'),
-- Obsidian
('obsidian', 'windows', 'default', 'winget install Obsidian.Obsidian'),
('obsidian', 'macos', 'default', 'brew install --cask obsidian'),
('obsidian', 'linux', 'apt', 'flatpak install flathub md.obsidian.Obsidian'),
('obsidian', 'linux', 'pacman', 'sudo pacman -S obsidian'),
('obsidian', 'linux', 'dnf', 'flatpak install flathub md.obsidian.Obsidian'),
-- Joplin
('joplin', 'windows', 'default', 'winget install Joplin.Joplin'),
('joplin', 'macos', 'default', 'brew install --cask joplin'),
('joplin', 'linux', 'apt', 'wget -O - https://raw.githubusercontent.com/laurent22/joplin/dev/Joplin_install_and_update.sh | bash'),
('joplin', 'linux', 'pacman', 'yay -S joplin-appimage'),
('joplin', 'linux', 'dnf', 'flatpak install flathub net.cozic.joplin_desktop'),
-- Standard Notes
('standard-notes', 'windows', 'default', 'winget install StandardNotes.StandardNotes'),
('standard-notes', 'macos', 'default', 'brew install --cask standard-notes'),
('standard-notes', 'linux', 'apt', 'sudo snap install standard-notes'),
('standard-notes', 'linux', 'pacman', 'yay -S standardnotes-desktop'),
('standard-notes', 'linux', 'dnf', 'flatpak install flathub org.standardnotes.standardnotes'),
-- Logseq
('logseq', 'windows', 'default', 'winget install Logseq.Logseq'),
('logseq', 'macos', 'default', 'brew install --cask logseq'),
('logseq', 'linux', 'apt', 'flatpak install flathub com.logseq.Logseq'),
('logseq', 'linux', 'pacman', 'yay -S logseq-desktop-bin'),
('logseq', 'linux', 'dnf', 'flatpak install flathub com.logseq.Logseq'),
-- Cryptomator
('cryptomator', 'windows', 'default', 'winget install Cryptomator.Cryptomator'),
('cryptomator', 'macos', 'default', 'brew install --cask cryptomator'),
('cryptomator', 'linux', 'apt', 'sudo add-apt-repository ppa:sebastian-stenzel/cryptomator && sudo apt install cryptomator -y'),
('cryptomator', 'linux', 'pacman', 'sudo pacman -S cryptomator'),
('cryptomator', 'linux', 'dnf', 'flatpak install flathub org.cryptomator.Cryptomator'),
-- VeraCrypt
('veracrypt', 'windows', 'default', 'winget install IDRIX.VeraCrypt'),
('veracrypt', 'macos', 'default', 'brew install --cask veracrypt'),
('veracrypt', 'linux', 'apt', 'sudo add-apt-repository ppa:unit193/encryption && sudo apt install veracrypt -y'),
('veracrypt', 'linux', 'pacman', 'sudo pacman -S veracrypt'),
('veracrypt', 'linux', 'dnf', 'sudo dnf install veracrypt'),
-- GnuPG
('gnupg', 'windows', 'default', 'winget install GnuPG.GnuPG'),
('gnupg', 'macos', 'default', 'brew install gnupg'),
('gnupg', 'linux', 'apt', 'sudo apt install gnupg -y'),
('gnupg', 'linux', 'pacman', 'sudo pacman -S gnupg'),
('gnupg', 'linux', 'dnf', 'sudo dnf install gnupg'),
-- ProtonVPN
('protonvpn', 'windows', 'default', 'winget install Proton.ProtonVPN'),
('protonvpn', 'macos', 'default', 'brew install --cask protonvpn'),
('protonvpn', 'linux', 'apt', 'wget https://repo.protonvpn.com/debian/dists/stable/main/binary-all/protonvpn-stable-release_1.0.3-3_all.deb && sudo dpkg -i ./protonvpn-stable-release_1.0.3-3_all.deb && sudo apt update && sudo apt install proton-vpn-gnome-desktop'),
('protonvpn', 'linux', 'pacman', 'yay -S proton-vpn-gtk-app'),
('protonvpn', 'linux', 'dnf', 'sudo dnf install proton-vpn-gnome-desktop'),
-- Ente Auth
('ente-auth', 'windows', 'default', 'winget install ente.auth'),
('ente-auth', 'macos', 'default', 'brew install --cask ente-auth'),
('ente-auth', 'linux', 'apt', 'flatpak install flathub io.ente.auth'),
('ente-auth', 'linux', 'pacman', 'yay -S ente-auth-bin'),
('ente-auth', 'linux', 'dnf', 'flatpak install flathub io.ente.auth'),
-- Yubico Authenticator
('yubico-authenticator', 'windows', 'default', 'winget install Yubico.YubicoAuthenticator'),
('yubico-authenticator', 'macos', 'default', 'brew install --cask yubico-authenticator'),
('yubico-authenticator', 'linux', 'apt', 'sudo apt install yubioath-desktop -y'),
('yubico-authenticator', 'linux', 'pacman', 'sudo pacman -S yubico-authenticator'),
('yubico-authenticator', 'linux', 'dnf', 'sudo dnf install yubioath-desktop'),
-- VLC Media Player
('vlc', 'windows', 'default', 'winget install VideoLAN.VLC'),
('vlc', 'macos', 'default', 'brew install --cask vlc'),
('vlc', 'linux', 'apt', 'sudo apt install vlc -y'),
('vlc', 'linux', 'pacman', 'sudo pacman -S vlc'),
('vlc', 'linux', 'dnf', 'sudo dnf install vlc'),
-- FreeTube
('freetube', 'windows', 'default', 'winget install FreeTube.FreeTube'),
('freetube', 'macos', 'default', 'brew install --cask freetube'),
('freetube', 'linux', 'apt', 'flatpak install flathub io.freetubeapp.FreeTube'),
('freetube', 'linux', 'pacman', 'yay -S freetube-bin'),
('freetube', 'linux', 'dnf', 'flatpak install flathub io.freetubeapp.FreeTube'),
-- OBS Studio
('obs-studio', 'windows', 'default', 'winget install OBSProject.OBSStudio'),
('obs-studio', 'macos', 'default', 'brew install --cask obs'),
('obs-studio', 'linux', 'apt', 'sudo add-apt-repository ppa:obsproject/obs-studio && sudo apt install obs-studio -y'),
('obs-studio', 'linux', 'pacman', 'sudo pacman -S obs-studio'),
('obs-studio', 'linux', 'dnf', 'sudo dnf install obs-studio'),
-- VSCodium
('vscodium', 'windows', 'default', 'winget install VSCodium.VSCodium'),
('vscodium', 'macos', 'default', 'brew install --cask vscodium'),
('vscodium', 'linux', 'apt', 'flatpak install flathub com.vscodium.codium'),
('vscodium', 'linux', 'pacman', 'yay -S vscodium-bin'),
('vscodium', 'linux', 'dnf', 'flatpak install flathub com.vscodium.codium'),
-- Neovim
('neovim', 'windows', 'default', 'winget install Neovim.Neovim'),
('neovim', 'macos', 'default', 'brew install neovim'),
('neovim', 'linux', 'apt', 'sudo apt install neovim -y'),
('neovim', 'linux', 'pacman', 'sudo pacman -S neovim'),
('neovim', 'linux', 'dnf', 'sudo dnf install neovim'),
-- PeaZip
('peazip', 'windows', 'default', 'winget install PeaZip.PeaZip'),
('peazip', 'macos', 'default', 'brew install --cask peazip'),
('peazip', 'linux', 'apt', 'flatpak install flathub io.github.peazip.PeaZip'),
('peazip', 'linux', 'pacman', 'yay -S peazip-qt-bin'),
('peazip', 'linux', 'dnf', 'flatpak install flathub io.github.peazip.PeaZip');