document.addEventListener('DOMContentLoaded', () => {
    
    detectAndSelectOS();

    const tabButtons = document.querySelectorAll('.tab-btn');
    const categorySections = document.querySelectorAll('.category-section');

    tabButtons.forEach(button => {
        button.addEventListener('click', () => {
            const targetId = button.getAttribute('data-target');
            tabButtons.forEach(btn => btn.classList.remove('active'));
            button.classList.add('active');
            categorySections.forEach(section => section.classList.remove('active-tab'));
            document.getElementById(targetId).classList.add('active-tab');
        });
    });

    const mainContent = document.querySelector('.main-content');

    // Akordeon ve Kart Yönetimi
    mainContent.addEventListener('click', (e) => {
        
        // --- YENİ: "EKLE / SEÇİLDİ" BUTONU MANTIĞI ---
        const addBtn = e.target.closest('.add-to-batch-btn');
        if (addBtn) {
            addBtn.classList.toggle('selected');
            
            if (addBtn.classList.contains('selected')) {
                // Seçildiğinde Tik ikonu ve "Seçildi" yazısı
                addBtn.innerHTML = `<svg viewBox="0 0 24 24" width="14" height="14" stroke="currentColor" stroke-width="3" fill="none"><polyline points="20 6 9 17 4 12"></polyline></svg> Seçildi`;
            } else {
                // İptal edildiğinde Artı ikonu ve "Ekle" yazısı
                addBtn.innerHTML = `<svg viewBox="0 0 24 24" width="14" height="14" stroke="currentColor" stroke-width="2" fill="none"><line x1="12" y1="5" x2="12" y2="19"></line><line x1="5" y1="12" x2="19" y2="12"></line></svg> Ekle`;
            }
            
            updateBatchBar();
            return; // Akordeonun açılmasını engellemek için geri dön
        }

        const appHeader = e.target.closest('.app-header');
        
        if (appHeader && !e.target.closest('.os-selector') && !e.target.closest('.terminal-box')) {
            const card = appHeader.closest('.app-card');
            card.classList.toggle('is-open');
            return; 
        }

        const osBtn = e.target.closest('.os-btn');
        if (osBtn) {
            if (osBtn.classList.contains('active')) return;

            const card = osBtn.closest('.app-card');
            const allOsBtns = card.querySelectorAll('.os-btn');
            allOsBtns.forEach(btn => btn.classList.remove('active'));
            osBtn.classList.add('active');

            const selectedOS = osBtn.getAttribute('data-os');
            const appId = card.getAttribute('data-app-id');
            const distroSelect = card.querySelector('.distro-select');
            
            if (selectedOS === 'linux' && distroSelect) {
                distroSelect.style.display = 'inline-block';
            } else if (distroSelect) {
                distroSelect.style.display = 'none';
            }
            
            fetchCommand(appId, selectedOS, card);
            return;
        }

        const copyBtn = e.target.closest('.copy-btn');
        if (copyBtn) {
            const card = copyBtn.closest('.app-card');
            const commandText = card.querySelector('.command-text').innerText;
            
            navigator.clipboard.writeText(commandText).then(() => {
                const originalHTML = copyBtn.innerHTML;
                copyBtn.innerHTML = `<svg viewBox="0 0 24 24" width="14" height="14" stroke="currentColor" stroke-width="3" fill="none"><polyline points="20 6 9 17 4 12"></polyline></svg> Kopyalandı!`;
                copyBtn.style.color = 'var(--accent-green)';
                copyBtn.style.borderColor = 'var(--accent-green)';
                setTimeout(() => {
                    copyBtn.innerHTML = originalHTML;
                    copyBtn.style.color = 'var(--text-muted)';
                    copyBtn.style.borderColor = '#333';
                }, 2000);
            });
        }
    });

    mainContent.addEventListener('change', (e) => {
        if (e.target.classList.contains('distro-select')) {
            const card = e.target.closest('.app-card');
            const appId = card.getAttribute('data-app-id');
            fetchCommand(appId, 'linux', card);
        }
    });

    // --- TOPLU İNDİRME MANTIĞI GÜNCELLENDİ ---
    const downloadBtn = document.getElementById('download-script-btn');
    const batchOsSelect = document.getElementById('batch-os-select');

    downloadBtn.addEventListener('click', async () => {
        // Artık checkbox yerine 'selected' sınıfına sahip butonları arıyoruz
        const selectedBtns = document.querySelectorAll('.add-to-batch-btn.selected');
        const selectedApps = Array.from(selectedBtns).map(btn => btn.getAttribute('data-value'));
        const osSelection = batchOsSelect.value;

        const originalText = downloadBtn.innerText;
        downloadBtn.innerText = "Hazırlanıyor...";
        downloadBtn.disabled = true;

        try {
            const response = await fetch('generate_script.php', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ apps: selectedApps, os: osSelection })
            });

            if (response.ok) {
                const blob = await response.blob();
                const url = window.URL.createObjectURL(blob);
                const a = document.createElement('a');
                a.href = url;
                
                let ext = osSelection === 'windows' ? '.bat' : '.sh';
                a.download = `priveget_kurulum${ext}`;
                
                document.body.appendChild(a);
                a.click();
                a.remove();
                window.URL.revokeObjectURL(url);
            } else {
                alert("Dosya oluşturulurken hata oluştu.");
            }
        } catch (error) {
            console.error("Script Hatası:", error);
            alert("Bağlantı hatası.");
        } finally {
            downloadBtn.innerText = originalText;
            downloadBtn.disabled = false;
        }
    });
});

// Toplu barı gösterip gizleme fonksiyonu
function updateBatchBar() {
    // Checkbox yerine selected sınıfı olan buton sayısına bak
    const selectedCount = document.querySelectorAll('.add-to-batch-btn.selected').length;
    const batchBar = document.getElementById('batch-bar');
    document.getElementById('selected-count').innerText = selectedCount;
    
    if (selectedCount > 0) {
        batchBar.classList.add('visible');
    } else {
        batchBar.classList.remove('visible');
    }
}

async function fetchCommand(appId, selectedOS, cardElement) {
    const commandTextElement = cardElement.querySelector('.command-text');
    commandTextElement.innerText = "Komut yükleniyor...";
    commandTextElement.style.color = "var(--text-muted)";

    let selectedDistro = 'default';
    if (selectedOS === 'linux') {
        const distroDropdown = cardElement.querySelector('.distro-select');
        if (distroDropdown) {
            selectedDistro = distroDropdown.value;
        } else {
            selectedDistro = 'apt'; 
        }
    }

    try {
        const response = await fetch('api.php', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ appId: appId, os: selectedOS, distro: selectedDistro })
        });

        const data = await response.json();

        if (data.status === 'success') {
            commandTextElement.innerText = data.command;
            commandTextElement.style.color = "var(--accent-green)";
        } else {
            commandTextElement.innerText = data.message;
            commandTextElement.style.color = "#ff5f56"; 
        }
    } catch (error) {
        console.error("Hata:", error);
        commandTextElement.innerText = "Veritabanına bağlanılamadı.";
        commandTextElement.style.color = "#ff5f56";
    }
}

function detectAndSelectOS() {
    const userAgent = window.navigator.userAgent.toLowerCase();
    let detectedOS = 'windows';

    if (userAgent.indexOf('linux') !== -1 && userAgent.indexOf('android') === -1) {
        detectedOS = 'linux';
    } else if (userAgent.indexOf('mac') !== -1 && userAgent.indexOf('iphone') === -1 && userAgent.indexOf('ipad') === -1) {
        detectedOS = 'macos';
    }

    const batchSelect = document.getElementById('batch-os-select');
    if(batchSelect) {
        if(detectedOS === 'linux') batchSelect.value = 'linux-apt';
        else batchSelect.value = detectedOS;
    }

    const allCards = document.querySelectorAll('.app-card');
    allCards.forEach(card => {
        const appId = card.getAttribute('data-app-id');
        const targetBtn = card.querySelector(`.os-btn[data-os="${detectedOS}"]`);

        if (targetBtn) {
            const allBtns = card.querySelectorAll('.os-btn');
            allBtns.forEach(btn => btn.classList.remove('active'));
            targetBtn.classList.add('active');
            
            const distroSelect = card.querySelector('.distro-select');
            if (detectedOS === 'linux' && distroSelect) {
                distroSelect.style.display = 'inline-block';
            }
            
            fetchCommand(appId, detectedOS, card);
        }
    });
}