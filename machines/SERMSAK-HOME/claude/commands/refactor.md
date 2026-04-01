---
description: ปรับโครงสร้างโค้ด - ทำให้โค้ดสะอาด เร็ว และปลอดภัยขึ้น
argument-hint: <ไฟล์> [โฟกัส: clean|performance|security]
---

# Refactor Code - ปรับปรุงโครงสร้าง code

## คำสั่ง
```
/refactor <file or folder path> [focus: clean|performance|security|all]
```

## หน้าที่
ปรับปรุง code ให้ดีขึ้นโดยไม่เปลี่ยน behavior

## Focus Areas

### clean - Clean Code
- Remove duplication (DRY)
- Improve naming
- Extract functions
- Simplify logic
- Remove dead code

### performance - Performance
- Optimize queries
- Add caching
- Reduce memory usage
- Improve algorithms

### security - Security
- Fix vulnerabilities
- Add input validation
- Escape output
- Use prepared statements

### all - ทุกด้าน

## Refactoring Patterns

### Extract Method
```php
// Before
function process() {
    // 50 lines of code
}

// After
function process() {
    $data = fetchData();
    $result = transformData($data);
    return saveResult($result);
}
```

### Replace Magic Numbers
```php
// Before
if ($level > 100) { }

// After
const MAX_LEVEL = 100;
if ($level > MAX_LEVEL) { }
```

### Guard Clauses
```php
// Before
function process($data) {
    if ($data) {
        if ($data['valid']) {
            // main logic
        }
    }
}

// After
function process($data) {
    if (!$data) return;
    if (!$data['valid']) return;
    // main logic
}
```

## Output Format

```markdown
# Refactoring Plan: [filename]

## Summary
- Current Issues: X
- Proposed Changes: Y
- Risk Level: Low/Medium/High

## Changes

### 1. [Change Name]
**Before:**
```code
// old code
```

**After:**
```code
// new code
```

**Benefit:** [why this is better]

## Migration Steps
1. [ ] Step 1
2. [ ] Step 2
3. [ ] Test

## Risks
- [potential issues]
```

## ตัวอย่าง

```
/refactor public/items.php clean
/refactor utils/helpers.php performance
/refactor public/login.php security
```
