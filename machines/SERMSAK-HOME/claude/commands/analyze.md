---
description: วิเคราะห์โค้ดเชิงลึก - ตรวจสอบคุณภาพ ความปลอดภัย และประสิทธิภาพ
argument-hint: <ไฟล์หรือโฟลเดอร์>
---

# Deep Code Analysis

วิเคราะห์ code อย่างละเอียดสำหรับ: $ARGUMENTS

## Analysis Dimensions

### 1. Architecture Analysis
- ตรวจสอบ design patterns ที่ใช้
- วิเคราะห์ coupling และ cohesion
- ตรวจสอบ SOLID principles
- ประเมิน scalability

### 2. Security Audit
- **Injection:** SQL, Command, LDAP, XPath
- **XSS:** Reflected, Stored, DOM-based
- **Authentication:** Weak passwords, session management
- **Authorization:** Privilege escalation, IDOR
- **Crypto:** Weak algorithms, key management
- **Secrets:** Hardcoded credentials, API keys

### 3. Performance Profiling
- Time complexity analysis (Big O)
- Space complexity analysis
- Database query optimization
- N+1 query detection
- Memory leak detection
- Caching opportunities

### 4. Code Quality
- Type safety
- Error handling coverage
- Dead code detection
- Code duplication (DRY violations)
- Naming conventions
- Documentation coverage

### 5. Dependency Analysis
- Outdated packages
- Known vulnerabilities (CVE)
- Unused dependencies
- Circular dependencies
- License compliance

## Output Format

```markdown
## Executive Summary
[สรุปผลการวิเคราะห์โดยรวม]

## Findings by Severity

### 🔴 CRITICAL (ต้องแก้ทันที)
| Issue | Location | Impact | Fix |
|-------|----------|--------|-----|
| ...   | ...      | ...    | ... |

### 🟠 HIGH (ควรแก้เร็ว)
...

### 🟡 MEDIUM (ควรแก้)
...

### 🟢 LOW (แนะนำ)
...

## Recommendations
1. Short-term (แก้ได้เลย)
2. Medium-term (วางแผนแก้)
3. Long-term (ปรับปรุงระบบ)

## Metrics
- Security Score: X/100
- Performance Score: X/100
- Code Quality Score: X/100
- Overall: X/100
```
