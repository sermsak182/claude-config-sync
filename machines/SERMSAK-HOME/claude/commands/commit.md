---
description: สร้าง Git Commit - สร้าง commit message อัตโนมัติ
argument-hint: [message hint]
---

# Smart Git Commit

สร้าง commit message อัตโนมัติสำหรับ: $ARGUMENTS

## Commit Message Format (Conventional Commits):

```
<type>(<scope>): <subject>

<body>

<footer>
```

### Types:
- **feat**: เพิ่ม feature ใหม่
- **fix**: แก้ bug
- **docs**: แก้ไข documentation
- **style**: formatting, semicolons, etc (ไม่กระทบ logic)
- **refactor**: refactor code (ไม่เพิ่ม feature, ไม่แก้ bug)
- **perf**: ปรับปรุง performance
- **test**: เพิ่ม/แก้ไข tests
- **build**: แก้ไข build system, dependencies
- **ci**: แก้ไข CI configuration
- **chore**: งานอื่นๆ ที่ไม่กระทบ src/test

### Scope (optional):
- ระบุส่วนที่แก้ไข เช่น auth, api, ui, db

### Subject:
- ไม่เกิน 50 ตัวอักษร
- ใช้ imperative mood ("add" ไม่ใช่ "added")
- ไม่มี period ท้าย

### Body (optional):
- อธิบายว่าทำอะไร และทำไม
- Wrap ที่ 72 ตัวอักษร

### Footer (optional):
- Breaking changes: `BREAKING CHANGE: description`
- Issue references: `Closes #123`

## กระบวนการ:

1. **Analyze Changes**
   - รัน `git diff --staged`
   - วิเคราะห์ไฟล์ที่เปลี่ยนแปลง
   - สรุปการเปลี่ยนแปลง

2. **Generate Message**
   - เลือก type ที่เหมาะสม
   - ระบุ scope (ถ้ามี)
   - เขียน subject ที่กระชับ

3. **Create Commit**
   - สร้าง commit ด้วย message ที่สร้าง
   - แสดงผลลัพธ์

## Examples:

```bash
# Feature
feat(auth): add JWT refresh token support

# Bug fix
fix(api): handle null response from external service

# Refactor
refactor(user): extract validation logic to separate module

# Breaking change
feat(api)!: change response format to JSON:API spec

BREAKING CHANGE: API responses now follow JSON:API specification
```

## Output:
แสดง commit message ที่สร้าง และถามยืนยันก่อน commit
