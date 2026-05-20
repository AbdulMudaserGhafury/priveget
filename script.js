document.addEventListener('DOMContentLoaded', async () => {
    
    await loadAppsDynamically();
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

    mainContent.addEventListener('click', (e) => {
        const addBtn = e.target.closest('.add-to-batch-btn');
        if (addBtn) {
            addBtn.classList.toggle('selected');
            if (addBtn.classList.contains('selected')) {
                addBtn.innerHTML = `<svg viewBox="0 0 24 24" width="14" height="14" stroke="currentColor" stroke-width="3" fill="none"><polyline points="20 6 9 17 4 12"></polyline></svg> Seçildi`;
            } else {
                addBtn.innerHTML = `<svg viewBox="0 0 24 24" width="14" height="14" stroke="currentColor" stroke-width="2" fill="none"><line x1="12" y1="5" x2="12" y2="19"></line><line x1="5" y1="12" x2="19" y2="12"></line></svg> Ekle`;
            }
            updateBatchBar();
            return; 
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
        if (copyBtn && !e.target.closest('#copy-modal-btn')) { 
            const card = copyBtn.closest('.app-card');
            const commandText = card.querySelector('.command-text').innerText;
            copyToClipboard(commandText, copyBtn);
        }
    });

    mainContent.addEventListener('change', (e) => {
        if (e.target.classList.contains('distro-select')) {
            const card = e.target.closest('.app-card');
            const appId = card.getAttribute('data-app-id');
            fetchCommand(appId, 'linux', card);
        }
    });

    const generateBtn = document.getElementById('generate-script-btn');
    const batchOsSelect = document.getElementById('batch-os-select');
    const modal = document.getElementById('code-modal');
    const closeModalBtn = document.getElementById('close-modal-btn');
    const copyModalBtn = document.getElementById('copy-modal-btn');
    const codeBlock = document.getElementById('generated-code-block');

    closeModalBtn.addEventListener('click', () => modal.classList.remove('active'));
    window.addEventListener('click', (e) => {
        if(e.target === modal) modal.classList.remove('active'); //TODO - sonra bu kismi gozden gecir
    });

    generateBtn.addEventListener('click', async () => {
        const selectedBtns = document.querySelectorAll('.add-to-batch-btn.selected');
        const selectedApps = Array.from(selectedBtns).map(btn => btn.getAttribute('data-value'));
        const osSelection = batchOsSelect.value;

        const originalText = generateBtn.innerText;
        generateBtn.innerText = "Oluşturuluyor...";
        generateBtn.disabled = true;

        try {
            const response = await fetch('generate_script.php', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ apps: selectedApps, os: osSelection })
            });

            const data = await response.json();

            if (data.status === 'success') {
                codeBlock.innerText = data.script;
                modal.classList.add('active');
            } else {
                alert(data.message || "Hata oluştu.");
            }
        } catch (error) {
            console.error("Hata:", error);
            alert("Bağlantı hatası.");
        } finally {
            generateBtn.innerText = originalText;
            generateBtn.disabled = false;
        }
    });

    // toplu kopyalma butonu kismi
    copyModalBtn.addEventListener('click', () => {
        copyToClipboard(codeBlock.innerText, copyModalBtn);
    });
});

// yardimci kopyalama
function copyToClipboard(text, buttonElement) {
    navigator.clipboard.writeText(text).then(() => {
        const originalHTML = buttonElement.innerHTML;
        buttonElement.innerHTML = `<svg viewBox="0 0 24 24" width="14" height="14" stroke="currentColor" stroke-width="3" fill="none"><polyline points="20 6 9 17 4 12"></polyline></svg> Kopyalandı!`;
        buttonElement.style.color = 'var(--accent-green)';
        buttonElement.style.borderColor = 'var(--accent-green)';
        setTimeout(() => {
            buttonElement.innerHTML = originalHTML;
            buttonElement.style.color = 'var(--text-muted)';
            buttonElement.style.borderColor = '#333';
        }, 2000);
    });
}

function updateBatchBar() {
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
//otomatik isletim sistemi algilama kismi
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
}//indexte bahsettigim bos divlerin icini doldurma kismi
async function loadAppsDynamicly() {
    try {
        const response = await fetch('get_apps.php');
        const data2 = await response.json();

        if (data2.status === 'success') {
            data2.data.forEach(app => {
                const container = document.getElementById(`${app.category}-container`);
                if (!container) return;

                const cardHtml = `
                <article class="app-card" data-app-id="${app.app_id}">
                    <div class="app-info">
                        <div class="app-header">
                            <button class="add-to-batch-btn" data-value="${app.app_id}"><svg viewBox="0 0 24 24" width="14" height="14" stroke="currentColor" stroke-width="2" fill="none"><line x1="12" y1="5" x2="12" y2="19"></line><line x1="5" y1="12" x2="19" y2="12"></line></svg> Ekle</button>
                            <div class="app-details">
                                <h3 class="app-name">${app.app_name}</h3>
                                <p class="app-desc">${app.app_desc}</p>
                            </div>
                            <button class="toggle-btn"><svg viewBox="0 0 24 24" width="24" height="24" stroke="currentColor" stroke-width="2" fill="none" stroke-linecap="round" stroke-linejoin="round" class="chevron-icon"><polyline points="6 9 12 15 18 9"></polyline></svg></button>
                        </div>
                        <div class="os-selector">
                            <button class="os-btn" data-os="windows">Windows</button>
                            <div class="linux-group" style="display: flex; gap: 5px;">
                                <button class="os-btn" data-os="linux">Linux</button>
                                <select class="distro-select" style="display: none;">
                                    <option value="apt">Ubuntu/Debian (apt)</option>
                                    <option value="pacman">Arch (pacman/yay)</option>
                                    <option value="dnf">Fedora (dnf)</option>
                                </select>
                            </div>
                            <button class="os-btn" data-os="macos">macOS</button>
                        </div>
                    </div>
                    <div class="terminal-container">
                        <div class="terminal-box">
                            <div class="terminal-header">
                                <div class="terminal-dots"><span class="dot red"></span><span class="dot yellow"></span><span class="dot green"></span></div>
                                <button class="copy-btn"><svg viewBox="0 0 24 24" width="14" height="14" stroke="currentColor" stroke-width="2" fill="none"><rect x="9" y="9" width="13" height="13" rx="2" ry="2"></rect><path d="M5 15H4a2 2 0 0 1-2-2V4a2 2 0 0 1 2-2h9a2 2 0 0 1 2 2v1"></path></svg> kopyala</button>
                            </div>
                            <div class="terminal-code"><span class="prompt">$</span> <span class="command-text">Yükleniyor...</span></div>
                        </div>
                    </div>
                </article>`;
                
                container.insertAdjacentHTML('beforeend', cardHtml);
            });
        }
    } catch (error) {
        console.error("Uygulamalar yüklenirken hata oluştu:", error);
    }
}