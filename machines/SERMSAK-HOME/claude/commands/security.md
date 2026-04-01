---
description: ตรวจสอบความปลอดภัย - Audit ตาม OWASP Top 10
argument-hint: <ไฟล์หรือโฟลเดอร์>
---

# Security Audit

ตรวจสอบความปลอดภัยเชิงลึกสำหรับ: $ARGUMENTS

## Security Checklist:

### 1. OWASP Top 10
- **Injection** (SQL, NoSQL, OS, LDAP)
- **Broken Authentication**
- **Sensitive Data Exposure**
- **XML External Entities (XXE)**
- **Broken Access Control**
- **Security Misconfiguration**
- **Cross-Site Scripting (XSS)**
- **Insecure Deserialization**
- **Using Components with Known Vulnerabilities**
- **Insufficient Logging & Monitoring**

### 2. Authentication & Authorization
- Password hashing (bcrypt, argon2)
- JWT implementation ถูกต้อง
- Session management
- Role-based access control (RBAC)
- OAuth/OAuth2 implementation

### 3. Input Validation
- Whitelist validation
- Input sanitization
- File upload validation
- Content-Type validation
- Size limits

### 4. Data Protection
- Encryption at rest
- Encryption in transit (TLS)
- Sensitive data handling
- PII protection
- Secrets management

### 5. API Security
- Rate limiting
- API key management
- CORS configuration
- Request validation
- Response filtering

### 6. Infrastructure
- HTTP Security Headers
- CSP (Content Security Policy)
- HTTPS enforcement
- Cookie security flags
- Error handling (ไม่ leak info)

### 7. Dependencies
- ตรวจสอบ vulnerable packages
- Outdated dependencies
- License compliance

## Output Format:

### CRITICAL (ต้องแก้ทันที)
- ช่องโหว่ที่ exploit ได้ง่าย
- มีผลกระทบสูง

### HIGH
- ช่องโหว่ที่ต้องแก้เร็ว
- มีความเสี่ยงสูง

### MEDIUM
- ปัญหาที่ควรแก้ไข
- Best practices ที่ขาด

### LOW
- ข้อเสนอแนะเพิ่มเติม
- Hardening recommendations

### สำหรับแต่ละ Issue:
1. **ตำแหน่ง**: file:line
2. **ประเภท**: OWASP category
3. **คำอธิบาย**: อธิบายช่องโหว่
4. **PoC**: วิธี exploit (ถ้าปลอดภัย)
5. **วิธีแก้ไข**: code ที่ถูกต้อง
6. **References**: OWASP, CWE links
