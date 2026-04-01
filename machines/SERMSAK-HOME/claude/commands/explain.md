---
description: อธิบายโค้ด - อธิบายการทำงานของโค้ดให้เข้าใจง่าย
argument-hint: <ไฟล์ที่ต้องการอธิบาย>
---

# Explain Code - อธิบาย code แบบเข้าใจง่าย

## คำสั่ง
```
/explain <file path or code snippet>
```

## หน้าที่
อธิบาย code ให้เข้าใจง่าย เหมาะสำหรับการเรียนรู้และทำความเข้าใจระบบ

## ระดับการอธิบาย

### 1. Overview (ภาพรวม)
- ไฟล์นี้ทำอะไร
- เกี่ยวข้องกับส่วนไหนของระบบ
- Dependencies และ relationships

### 2. Function-by-Function
- แต่ละ function ทำอะไร
- Parameters และ return values
- Side effects

### 3. Line-by-Line (ถ้าซับซ้อน)
- อธิบายทีละบรรทัด
- Logic flow
- Edge cases

### 4. Data Flow
- ข้อมูลไหลอย่างไร
- Input → Processing → Output
- State changes

## Output Format

```markdown
# Code Explanation: [filename]

## 📋 Overview
[ภาพรวมของไฟล์]

## 🔧 Key Functions

### functionName()
**Purpose:** [อธิบายสั้นๆ]
**Parameters:**
- `param1` - [description]
**Returns:** [what it returns]
**Example:**
```code
// usage example
```

## 📊 Data Flow
```
Input → [Step 1] → [Step 2] → Output
```

## 🔗 Dependencies
- [file1] - ใช้ทำ...
- [file2] - ใช้ทำ...

## 💡 Key Concepts
[อธิบาย concepts สำคัญ]
```

## ตัวอย่าง

```
/explain public/api/item_icon.php
/explain Laghaim/Combat.cpp
/explain common/packet_define.h
```

## Notes
- ใช้ภาษาไทยในการอธิบาย
- เน้นความเข้าใจมากกว่า technical details
- ยกตัวอย่างประกอบ
