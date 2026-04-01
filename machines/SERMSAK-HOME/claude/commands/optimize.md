---
description: เพิ่มประสิทธิภาพ - วิเคราะห์และ optimize โค้ด
argument-hint: <file or folder path>
---

# Performance Optimization

วิเคราะห์และ optimize performance สำหรับ: $ARGUMENTS

## การวิเคราะห์ที่ต้องทำ:

### 1. Bottleneck Detection
- ระบุจุดที่ช้าที่สุดใน code
- วิเคราะห์ critical path
- ตรวจหา blocking operations

### 2. Database Optimization
- ตรวจสอบ query efficiency (N+1 problems)
- เสนอ indexes ที่ควรเพิ่ม
- ตรวจสอบ JOIN patterns
- วิเคราะห์ query plans

### 3. Algorithm Analysis
- วิเคราะห์ time complexity (Big O)
- วิเคราะห์ space complexity
- เสนอ alternative algorithms ที่ดีกว่า

### 4. Memory Management
- ตรวจหา memory leaks
- วิเคราะห์ memory allocation patterns
- เสนอ garbage collection optimization

### 5. Caching Strategy
- ระบุ data ที่ควร cache
- เสนอ caching layer (Redis, in-memory)
- วิเคราะห์ cache invalidation strategy

### 6. Network & I/O
- ตรวจหา redundant API calls
- เสนอ batching strategies
- วิเคราะห์ async/parallel processing opportunities

## Output Format:

### CURRENT STATE
- สรุปสถานะปัจจุบัน
- ระบุ metrics ที่วัดได้

### BOTTLENECK
- ระบุจุดที่เป็น bottleneck พร้อมเหตุผล

### SOLUTION
- เสนอวิธีแก้ไขพร้อม code
- อธิบายเหตุผลว่าทำไมถึงดีกว่า

### EXPECTED GAIN
- ประมาณการปรับปรุง performance
- ระบุ trade-offs ถ้ามี
