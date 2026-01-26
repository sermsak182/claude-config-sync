# Claude Config Sync

Sync Claude Code และ VS Code configuration ข้ามหลายเครื่อง

## โครงสร้าง

```
claude-config-sync/
├── shared/              # Config กลาง ใช้ร่วมกันทุกเครื่อง
│   ├── claude/
│   ├── vscode/
│   └── extensions.txt
├── machines/            # Config เฉพาะเครื่อง
│   ├── IT-Support/
│   ├── PC-HOME/
│   └── .../
└── scripts/
    ├── export.ps1       # Export config จากเครื่องปัจจุบัน
    ├── import.ps1       # Import config มาใช้
    └── sync.ps1         # Sync กับ GitHub
```

## Quick Start

### เครื่องใหม่ (Clone และ Import)

```powershell
# Clone repository
git clone https://github.com/sermsak182/claude-config-sync.git
cd claude-config-sync

# Import shared config
.\scripts\import.ps1 -Source shared

# หรือ import จากเครื่องอื่น
.\scripts\import.ps1 -Source IT-Support
```

### Export Config เครื่องปัจจุบัน

```powershell
# Export config ไปยัง machines/<hostname>/
.\scripts\export.ps1

# Commit และ push
git add . && git commit -m "export: <hostname>" && git push
```

### Sync (Pull + Export + Push)

```powershell
# Full sync
.\scripts\sync.ps1

# Pull only (ไม่ push)
.\scripts\sync.ps1 -PullOnly

# Push only (ไม่ pull)
.\scripts\sync.ps1 -PushOnly
```

## Scripts

### export.ps1

Export config จากเครื่องปัจจุบันไปยัง `machines/<hostname>/`:
- Claude config (`~/.claude/`)
- VS Code settings, keybindings, snippets
- Extensions list

### import.ps1

Import config มาใช้:

```powershell
# Import จาก shared/
.\scripts\import.ps1 -Source shared

# Import จากเครื่องอื่น
.\scripts\import.ps1 -Source PC-OFFICE

# Preview ก่อน (dry run)
.\scripts\import.ps1 -Source shared -DryRun
```

### sync.ps1

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

```powershell
# รันทุกครั้งที่ต้องการ sync
.\scripts\sync.ps1
```

## Security

- ไม่เก็บ API keys, passwords, secrets
- ไฟล์ที่มี sensitive data จะถูก skip อัตโนมัติ
- ตรวจสอบก่อน commit ทุกครั้ง

## Notes

- Hostname ใช้จาก `$env:COMPUTERNAME` อัตโนมัติ
- Backup ไฟล์เดิมก่อน import เสมอ (*.backup)
- รองรับ Windows (PowerShell)
