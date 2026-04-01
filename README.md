# Claude Config Sync

Sync Claude Code และ VS Code configuration ข้ามหลายเครื่อง — รองรับ **Windows** และ **macOS/Linux**

## One-Liner Setup (เครื่องใหม่)

**Windows (PowerShell):**
```powershell
irm https://raw.githubusercontent.com/sermsak182/claude-config-sync/master/scripts/quick-setup.ps1 | iex
```

**macOS/Linux (Terminal):**
```bash
curl -sL https://raw.githubusercontent.com/sermsak182/claude-config-sync/master/scripts/quick-setup.sh | bash
```

สิ่งที่จะได้:
- ✅ Clone repository ไปยัง `$HOME/claude-config-sync`
- ✅ Import VS Code settings, keybindings, snippets
- ✅ Install extensions
- ✅ พร้อมใช้งานทันที

---

## โครงสร้าง

```
claude-config-sync/
├── shared/              # Config กลาง ใช้ร่วมกันทุกเครื่อง
│   ├── claude/
│   ├── vscode/
│   └── extensions.txt
├── machines/            # Config เฉพาะเครื่อง
│   ├── IT-Support/      # Windows
│   ├── SERMSAK-HOME/    # Windows
│   ├── MacBook-Air-.../  # macOS
│   └── .../
└── scripts/
    ├── export.ps1       # Windows - Export config
    ├── import.ps1       # Windows - Import config
    ├── sync.ps1         # Windows - Sync กับ GitHub
    ├── quick-setup.ps1  # Windows - One-liner setup
    ├── export.sh        # macOS/Linux - Export config
    ├── import.sh        # macOS/Linux - Import config
    ├── sync.sh          # macOS/Linux - Sync กับ GitHub
    └── quick-setup.sh   # macOS/Linux - One-liner setup
```

## Quick Start

### เครื่องใหม่ (Clone และ Import)

**Windows:**
```powershell
git clone https://github.com/sermsak182/claude-config-sync.git
cd claude-config-sync
.\scripts\import.ps1 -Source shared
```

**macOS/Linux:**
```bash
git clone https://github.com/sermsak182/claude-config-sync.git
cd claude-config-sync
./scripts/import.sh --source shared
```

### Export Config เครื่องปัจจุบัน

**Windows:**
```powershell
.\scripts\export.ps1
git add . && git commit -m "export: %COMPUTERNAME%" && git push
```

**macOS/Linux:**
```bash
./scripts/export.sh
git add . && git commit -m "export: $(hostname -s)" && git push
```

### Sync (Pull + Export + Push)

**Windows:**
```powershell
.\scripts\sync.ps1              # Full sync
.\scripts\sync.ps1 -PullOnly    # Pull only
.\scripts\sync.ps1 -PushOnly    # Push only
```

**macOS/Linux:**
```bash
./scripts/sync.sh               # Full sync
./scripts/sync.sh --pull-only   # Pull only
./scripts/sync.sh --push-only   # Push only
```

## Scripts

### export (.ps1 / .sh)

Export config จากเครื่องปัจจุบันไปยัง `machines/<hostname>/`:
- Claude config (`~/.claude/`)
- VS Code settings, keybindings, snippets
- Extensions list
- Machine info (OS, arch, timestamp)

### import (.ps1 / .sh)

Import config มาใช้:

**Windows:**
```powershell
.\scripts\import.ps1 -Source shared        # Import จาก shared/
.\scripts\import.ps1 -Source PC-OFFICE     # Import จากเครื่องอื่น
.\scripts\import.ps1 -Source shared -DryRun  # Preview ก่อน
```

**macOS/Linux:**
```bash
./scripts/import.sh --source shared        # Import จาก shared/
./scripts/import.sh --source PC-OFFICE     # Import จากเครื่องอื่น
./scripts/import.sh --source shared --dry-run  # Preview ก่อน
```

### sync (.ps1 / .sh)

Sync อัตโนมัติ: Pull -> Export -> Commit -> Push

## Workflow แนะนำ

### เครื่องหลัก (Main Machine)

1. ตั้งค่า config ตามต้องการ
2. Export และ copy ไปยัง `shared/`
3. Push to GitHub

### เครื่องอื่นๆ

1. Clone repository
2. Import จาก `shared/`
3. ปรับแต่งเฉพาะเครื่อง (ถ้าต้องการ)
4. Export และ push

### Sync ประจำวัน

```bash
# macOS/Linux
./scripts/sync.sh

# Windows
.\scripts\sync.ps1
```

## Machines

| Hostname | OS | Description |
|----------|----|-------------|
| IT-Support | Windows | เครื่องที่ทำงาน |
| SERMSAK-HOME | Windows | เครื่องบ้าน |
| LHDR-SV | Windows | Server |
| MacBook-Air-khxng-Sermsak | macOS | MacBook Air (Apple Silicon) |

## Security

- ไม่เก็บ API keys, passwords, secrets
- ไฟล์ที่มี sensitive data จะถูก skip อัตโนมัติ
- ตรวจสอบก่อน commit ทุกครั้ง
- Backup ไฟล์เดิมก่อน import เสมอ (*.backup)

## Notes

- **Windows**: Hostname ใช้จาก `$env:COMPUTERNAME`
- **macOS/Linux**: Hostname ใช้จาก `hostname -s`
- รองรับ Windows (PowerShell) + macOS/Linux (Bash)
