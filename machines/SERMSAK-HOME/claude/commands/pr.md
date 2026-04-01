---
description: สร้าง Pull Request - สร้าง PR พร้อม description
argument-hint: [branch or PR number]
---

# Pull Request Generator

สร้าง Pull Request สำหรับ: $ARGUMENTS

## PR Template:

```markdown
## Summary
[สรุปสั้นๆ ว่า PR นี้ทำอะไร]

## Changes
- [รายการการเปลี่ยนแปลงหลัก]

## Type of Change
- [ ] Bug fix (non-breaking change)
- [ ] New feature (non-breaking change)
- [ ] Breaking change
- [ ] Documentation update
- [ ] Refactoring
- [ ] Performance improvement

## Testing
- [ ] Unit tests added/updated
- [ ] Integration tests added/updated
- [ ] Manual testing performed

## Screenshots (if applicable)
[แนบ screenshots ถ้ามี UI changes]

## Checklist
- [ ] Code follows project style guidelines
- [ ] Self-review completed
- [ ] Comments added for complex logic
- [ ] Documentation updated
- [ ] No new warnings introduced
```

## กระบวนการ:

1. **Analyze Branch**
   - ตรวจสอบ commits ใน branch
   - วิเคราะห์ไฟล์ที่เปลี่ยนแปลง
   - ระบุ base branch

2. **Generate Content**
   - สร้าง summary จาก commits
   - ระบุประเภทการเปลี่ยนแปลง
   - สร้าง checklist

3. **Create PR**
   - ใช้ `gh pr create`
   - ตั้ง reviewers (ถ้าระบุ)
   - ตั้ง labels (ถ้าระบุ)

## Options:

```bash
# Basic PR
/pr

# With specific base branch
/pr --base develop

# With reviewers
/pr --reviewer @username

# Draft PR
/pr --draft
```

## Output:
สร้าง PR พร้อม link ไปยัง GitHub
