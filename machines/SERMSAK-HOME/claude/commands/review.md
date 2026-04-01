---
description: รีวิวโค้ด - ตรวจสอบคุณภาพแบบ Senior Developer
argument-hint: <ไฟล์หรือโฟลเดอร์>
---

# Code Review - รีวิว code แบบมืออาชีพ

## คำสั่ง
```
/review <file or folder path>
```

## หน้าที่
รีวิว code อย่างละเอียด เหมือน Senior Engineer ตรวจ Pull Request

## การวิเคราะห์

### 1. Code Quality
- Clean code principles
- SOLID principles
- DRY (Don't Repeat Yourself)
- Naming conventions
- Function complexity

### 2. Security
- SQL Injection
- XSS vulnerabilities
- CSRF protection
- Input validation
- Authentication/Authorization

### 3. Performance
- N+1 queries
- Memory leaks
- Caching opportunities
- Algorithm efficiency

### 4. Maintainability
- Code readability
- Documentation
- Test coverage
- Error handling

### 5. Best Practices
- Language-specific patterns
- Framework conventions
- Industry standards

## Output Format

```markdown
# Code Review: [filename]

## Summary
| Aspect | Score | Issues |
|--------|-------|--------|
| Quality | 🟢/🟡/🔴 | X |
| Security | 🟢/🟡/🔴 | X |
| Performance | 🟢/🟡/🔴 | X |

## 🔴 Critical (ต้องแก้)
1. [Issue] - Line X

## 🟡 Suggestions (ควรแก้)
1. [Suggestion] - Line X

## 🟢 Good Practices (ทำได้ดี)
1. [Good point]

## Recommended Changes
[Code with fixes]
```

## ตัวอย่าง

```
/review public/login.php
/review utils/helpers.php
/review Laghaim/Character.cpp
```
