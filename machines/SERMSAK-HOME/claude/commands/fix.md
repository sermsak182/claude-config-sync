---
description: แก้ไขปัญหาอัตโนมัติ - วิเคราะห์และแก้ไข bug หรือ error
argument-hint: <คำอธิบายปัญหาหรือ error message>
---

# Smart Auto-Fix

แก้ไขปัญหาอัตโนมัติสำหรับ: $ARGUMENTS

## Process

### Step 1: Understand
- วิเคราะห์ error message/issue description
- ค้นหาไฟล์ที่เกี่ยวข้อง
- ระบุ root cause

### Step 2: Plan
- วางแผนการแก้ไข
- ประเมิน impact
- เตรียม rollback plan

### Step 3: Fix
- แก้ไข code
- รักษา coding standards
- เพิ่ม error handling ถ้าจำเป็น

### Step 4: Verify
- ตรวจสอบ syntax
- ตรวจสอบ type safety
- ทดสอบ edge cases

### Step 5: Document
- สรุปสิ่งที่แก้ไข
- อธิบายเหตุผล
- แนะนำการป้องกันในอนาคต

## Fix Types

### Error Fixes
- Syntax errors
- Type errors
- Runtime errors
- Logic errors

### Performance Fixes
- Optimize algorithms
- Add caching
- Fix N+1 queries
- Reduce memory usage

### Security Fixes
- Input validation
- Output encoding
- Authentication/Authorization
- Encryption

### Code Quality Fixes
- Refactoring
- Remove duplication
- Improve naming
- Add error handling

## Output

```markdown
## Problem
[อธิบายปัญหาที่พบ]

## Root Cause
[สาเหตุที่แท้จริง]

## Solution
[วิธีแก้ไข]

## Changes Made
- file1.ts: [description]
- file2.ts: [description]

## Prevention
[วิธีป้องกันไม่ให้เกิดซ้ำ]
```
