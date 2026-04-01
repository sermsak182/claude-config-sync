---
description: เตรียม Deploy - สร้าง checklist ก่อน deploy
argument-hint: [env: staging|production]
---

# Deployment Checklist

Checklist ก่อน deploy สำหรับ: $ARGUMENTS

## Pre-deployment Verification:

### 1. Security Checklist
- [ ] ตรวจสอบไม่มี hardcoded secrets/credentials
- [ ] ตรวจสอบ environment variables ครบถ้วน
- [ ] ตรวจสอบ API keys ไม่ถูก expose
- [ ] ตรวจสอบ CORS configuration
- [ ] ตรวจสอบ rate limiting
- [ ] ตรวจสอบ input validation ทุกจุด
- [ ] ตรวจสอบ authentication/authorization
- [ ] ตรวจสอบ SQL injection protection
- [ ] ตรวจสอบ XSS protection

### 2. Testing Checklist
- [ ] Unit tests ผ่านหมด
- [ ] Integration tests ผ่านหมด
- [ ] E2E tests ผ่านหมด (ถ้ามี)
- [ ] Manual testing สำหรับ critical paths
- [ ] Performance testing (ถ้าจำเป็น)

### 3. Build Checklist
- [ ] Build สำเร็จไม่มี errors
- [ ] No TypeScript/Lint warnings ที่สำคัญ
- [ ] Bundle size อยู่ในเกณฑ์
- [ ] Assets ถูก optimize แล้ว
- [ ] Source maps configured ถูกต้อง

### 4. Database Checklist
- [ ] Migrations พร้อม deploy
- [ ] Rollback scripts พร้อม
- [ ] Backup ฐานข้อมูลก่อน deploy
- [ ] Indexes ที่จำเป็นถูกสร้างแล้ว
- [ ] Seeds/fixtures พร้อม (ถ้าจำเป็น)

### 5. Infrastructure Checklist
- [ ] Server resources เพียงพอ
- [ ] Load balancer configured
- [ ] SSL certificates valid
- [ ] DNS records correct
- [ ] CDN cache rules correct

### 6. Monitoring Checklist
- [ ] Error tracking configured (Sentry, etc.)
- [ ] Application logs configured
- [ ] Performance monitoring active
- [ ] Alerting rules set up
- [ ] Health check endpoints ready

### 7. Documentation Checklist
- [ ] API documentation updated
- [ ] CHANGELOG updated
- [ ] README updated (ถ้าจำเป็น)
- [ ] Deployment notes prepared
- [ ] Rollback procedure documented

## Output:

สร้าง deployment report ที่ระบุ:
1. Items ที่ผ่าน (PASS)
2. Items ที่ไม่ผ่าน (FAIL) พร้อมเหตุผล
3. Items ที่ต้อง manual verify (MANUAL)
4. คำแนะนำก่อน deploy
5. Rollback plan summary
