---
description: วิเคราะห์บั๊ก - หาสาเหตุและแก้ไขปัญหาจาก error message
argument-hint: <error message หรือคำอธิบายปัญหา>
---

# Debug Issue - วิเคราะห์และแก้ไข bug

## คำสั่ง
```
/debug <error message or issue description>
```

## หน้าที่
วิเคราะห์ปัญหาจาก error message หรือ description แล้วหาทางแก้ไข

## ขั้นตอนการวิเคราะห์

### 1. Error Parsing
- Parse error message
- Identify error type
- Extract file/line info

### 2. Context Gathering
- Read relevant files
- Check dependencies
- Review recent changes

### 3. Root Cause Analysis
- Identify actual cause
- Not just symptoms
- Trace execution flow

### 4. Solution Development
- Propose fixes
- Consider side effects
- Test solutions

## Error Categories

### PHP Errors
| Error | Common Cause | Fix |
|-------|--------------|-----|
| Undefined variable | Missing initialization | Add null check |
| Call to undefined function | Missing include | Add require_once |
| Class not found | Autoload issue | Check namespace |

### Database Errors
| Error | Common Cause | Fix |
|-------|--------------|-----|
| Connection refused | Wrong credentials | Check config |
| Column not found | Schema mismatch | Update schema |
| Duplicate key | Primary key exists | Use INSERT IGNORE |

### Game Server Errors (C++)
| Error | Common Cause | Fix |
|-------|--------------|-----|
| Null pointer | Missing null check | Add validation |
| Buffer overflow | Array bounds | Check size |
| Memory leak | Missing delete | Use smart pointers |

## Output Format

```markdown
# Debug Report

## Error
```
[Original error message]
```

## Analysis

### Error Type
[Type of error]

### Location
- File: [path]
- Line: [number]
- Function: [name]

### Root Cause
[Explanation of why this happened]

### Call Stack
```
[Stack trace if available]
```

## Solution

### Quick Fix
```code
[Immediate fix]
```

### Proper Fix
```code
[Complete solution]
```

### Prevention
[How to prevent this in future]

## Verification
```bash
[Commands to verify fix]
```
```

## ตัวอย่าง

```
/debug "PHP Fatal error: Uncaught PDOException: SQLSTATE[HY000]"
/debug "Item icon not loading for vnum 12345"
/debug "Player damage calculation wrong for skill 50"
/debug "Thai text showing as question marks"
```

## Quick Fixes Reference

### PHP
```php
// Undefined variable
$value = $data['key'] ?? '';

// Connection error
try {
    $db = getDbConnection(DB_DATA);
} catch (PDOException $e) {
    error_log($e->getMessage());
}
```

### C++
```cpp
// Null check
if (ch == nullptr) return;

// Bounds check
if (index >= 0 && index < MAX_SIZE) {
    // safe access
}
```

## Notes
- อ่าน error message ทั้งหมด
- ดู stack trace
- ตรวจสอบ recent changes
- Test หลังแก้ไข
