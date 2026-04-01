---
description: เริ่มต้นโปรเจค - สร้างโครงสร้างและไฟล์พื้นฐาน
argument-hint: <ประเภท: php|node|python|game>
---

# เริ่มต้นโปรเจค - สร้างโครงสร้างและไฟล์พื้นฐานสำหรับโปรเจคใหม่

## คำสั่ง
```
/init [project-type: php|node|python|game]
```

## หน้าที่
สร้างโครงสร้างพื้นฐานและไฟล์ config สำหรับ project ใหม่

## ขั้นตอนการทำงาน

1. **ถาม project type** (ถ้าไม่ระบุ)
2. **สร้างไฟล์พื้นฐาน**:
   - CLAUDE.md
   - .gitignore
   - .env.example
   - README.md
   - โครงสร้าง folder

## Output by Project Type

### PHP Project
```
project/
├── .claude/
│   └── settings.json
├── config/
│   └── config.php
├── public/
│   └── index.php
├── src/
├── tests/
├── .env.example
├── .gitignore
├── CLAUDE.md
└── README.md
```

### Node.js Project
```
project/
├── .claude/
│   └── settings.json
├── src/
│   └── index.ts
├── tests/
├── .env.example
├── .gitignore
├── package.json
├── tsconfig.json
├── CLAUDE.md
└── README.md
```

### Python Project
```
project/
├── .claude/
│   └── settings.json
├── src/
│   └── __init__.py
├── tests/
├── .env.example
├── .gitignore
├── requirements.txt
├── CLAUDE.md
└── README.md
```

### Game Server Project (Laghaim)
```
project/
├── .claude/
│   └── settings.json
├── config/
├── docs/
├── scripts/
├── sql/
├── .env.example
├── .gitignore
├── CLAUDE.md
└── README.md
```

## Generated Files

### CLAUDE.md Template
```markdown
# CLAUDE.md

## Project Overview
[Project name] - [Brief description]

## Tech Stack
- **Language**: [PHP/Node/Python]
- **Database**: [MySQL/PostgreSQL/etc.]
- **Framework**: [if any]

## Project Structure
[Directory structure explanation]

## Common Commands
[Build, test, run commands]

## Code Style
- [Naming conventions]
- [Formatting rules]

## Important Files
- [Key files and their purposes]
```

### .gitignore Template
```
# Environment
.env
.env.local
*.local

# Dependencies
vendor/
node_modules/
__pycache__/
*.pyc

# IDE
.idea/
.vscode/
*.swp

# Logs
*.log
logs/

# Cache
cache/
tmp/
temp/

# OS
.DS_Store
Thumbs.db

# Build
dist/
build/
```

### .env.example Template
```bash
# Application
APP_NAME=MyProject
APP_ENV=development
APP_DEBUG=true

# Database
DB_HOST=localhost
DB_PORT=3306
DB_NAME=database
DB_USER=root
DB_PASS=

# Security
APP_SECRET=change-this-secret-key
```

## ตัวอย่างการใช้งาน

```
/init php
/init node
/init python
/init game
```

## Notes
- ไม่ overwrite ไฟล์ที่มีอยู่แล้ว
- ถามยืนยันก่อนสร้าง
- Customize ตาม project type
- รวม best practices ตั้งแต่เริ่ม
