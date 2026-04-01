---
description: สร้าง Changelog - สร้างรายการเปลี่ยนแปลงจาก git
argument-hint: [version] [from-tag]
---

# Changelog Generator - สร้าง changelog จาก git

## คำสั่ง
```
/changelog [version] [from-tag]
```

## หน้าที่
สร้าง changelog อัตโนมัติจาก git commits ตาม conventional commits format

## ขั้นตอนการทำงาน

1. **อ่าน git commits** ตั้งแต่ tag ล่าสุด (หรือที่ระบุ)
2. **จัดกลุ่ม commits** ตาม type
3. **สร้าง changelog** ในรูปแบบมาตรฐาน

## Output Format

```markdown
# Changelog

## [1.2.0] - 2024-01-15

### ✨ Features
- **items**: Add pagination and search functionality (#123)
- **shops**: New bulk edit feature (#125)

### 🐛 Bug Fixes
- **auth**: Fix session timeout issue (#124)
- **api**: Resolve null pointer in item endpoint (#126)

### ♻️ Refactoring
- **helpers**: Extract common database functions
- **utils**: Consolidate flag parsing logic

### ⚡ Performance
- **items**: Optimize query with proper indexing
- **cache**: Add Redis caching layer

### 🔒 Security
- **api**: Sanitize all user inputs
- **auth**: Implement rate limiting

### 📝 Documentation
- Update API documentation
- Add setup guide for new developers

### 🔧 Chores
- Update dependencies
- Configure CI/CD pipeline

---

## [1.1.0] - 2024-01-01
[Previous release notes...]
```

## Commit Type Mapping

| Type | Section | Emoji |
|------|---------|-------|
| feat | Features | ✨ |
| fix | Bug Fixes | 🐛 |
| refactor | Refactoring | ♻️ |
| perf | Performance | ⚡ |
| security | Security | 🔒 |
| docs | Documentation | 📝 |
| test | Tests | ✅ |
| chore | Chores | 🔧 |
| style | Styles | 💄 |
| build | Build | 📦 |
| ci | CI/CD | 👷 |

## Git Commands Used

```bash
# Get commits since last tag
git log $(git describe --tags --abbrev=0)..HEAD --oneline

# Get all tags
git tag --sort=-version:refname

# Get commit details
git log --pretty=format:"%h|%s|%an|%ad" --date=short
```

## Additional Sections

### Breaking Changes
```markdown
### ⚠️ BREAKING CHANGES
- **api**: Changed response format for /items endpoint
  - Before: `{ items: [...] }`
  - After: `{ data: [...], meta: {...} }`
```

### Contributors
```markdown
### 👥 Contributors
- @developer1 (5 commits)
- @developer2 (3 commits)
```

### Stats
```markdown
### 📊 Stats
- **Commits**: 25
- **Files Changed**: 48
- **Insertions**: +1,234
- **Deletions**: -456
```

## ตัวอย่างการใช้งาน

```
/changelog                    # สร้างจาก tag ล่าสุด
/changelog 1.2.0              # ระบุ version ใหม่
/changelog 1.2.0 v1.1.0       # ระบุ from tag
```

## Output Options

### CHANGELOG.md
เพิ่มต่อท้ายไฟล์ CHANGELOG.md ที่มีอยู่

### Release Notes
สร้าง release notes สำหรับ GitHub release

### JSON Format
```json
{
  "version": "1.2.0",
  "date": "2024-01-15",
  "features": [...],
  "fixes": [...],
  "breaking": [...]
}
```

## Notes
- ใช้ conventional commits format
- รวม PR/issue references
- จัดกลุ่มตาม scope
- Include breaking changes warning
