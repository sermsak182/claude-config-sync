---
description: ซิงค์ Constants - ตรวจสอบ PHP กับ C++ ให้ตรงกัน
argument-hint: [action: check|php-to-cpp|cpp-to-php]
---

# Sync Constants - Sync PHP ↔ C++ Constants

## คำสั่ง
```
/sync [direction: check|php-to-cpp|cpp-to-php|report]
```

## หน้าที่
ตรวจสอบและ sync constants ระหว่าง PHP (dr-admin) และ C++ (Game Server)

## Context

### File Locations
```
PHP:  C:\xampp\htdocs\dr-admin\utils\item_constants.php
      C:\xampp\htdocs\dr-admin\utils\npc_constants.php

C++:  D:\02 LAGHAIM\...\01-DR-SERVER-SOURCE-CODE\Laghaim\ItemConfig.h
      D:\02 LAGHAIM\...\01-DR-SERVER-SOURCE-CODE\common\info_define.h
      D:\02 LAGHAIM\...\01-DR-SERVER-SOURCE-CODE\common\packet_define.h
```

## Output Format

### Check Output
```markdown
# Constants Sync Check

## Summary
| Category | PHP | C++ | Status |
|----------|-----|-----|--------|
| Item Flags | 30 | 32 | ⚠️ Mismatch |
| Race Flags | 12 | 12 | ✅ Synced |
| NPC Flags | 28 | 28 | ✅ Synced |
| Item Types | 6 | 6 | ✅ Synced |
| Zones | 35 | 35 | ✅ Synced |

## Mismatches Found

### Item Flags (IATT_*)
| Constant | PHP Value | C++ Value | Action |
|----------|-----------|-----------|--------|
| IATT_VIP_ONLY | missing | (1 << 23) | Add to PHP |
| IATT_NEW_FLAG | (1 << 24) | missing | Add to C++ |

### Packet Structures
| Struct | PHP Fields | C++ Fields | Status |
|--------|------------|------------|--------|
| ITEM_INFO | 15 | 17 | ⚠️ Check |

## Code Diff

### Missing in PHP
```php
// เพิ่มใน item_constants.php
define('IATT_VIP_ONLY', (1 << 23));     // VIP only item
define('IATT_UNTRADEABLE', (1 << 24));  // Cannot trade
```

### Missing in C++
```cpp
// เพิ่มใน ItemConfig.h
#define IATT_NEW_FLAG    (1 << 25)  // New flag from PHP
```
```

### Report Output
```markdown
# Constants Sync Report

## Item Attribute Flags (IATT_*)

| Bit | Name | PHP | C++ | Description |
|-----|------|-----|-----|-------------|
| 0 | IATT_NO_DROP | ✅ | ✅ | ไม่สามารถ drop |
| 1 | IATT_NO_SELL | ✅ | ✅ | ไม่สามารถขาย |
| 2 | IATT_BIND_ON_EQUIP | ✅ | ✅ | Bind เมื่อสวมใส่ |
| 3 | IATT_NO_EXCHANGE | ✅ | ✅ | ไม่สามารถแลกเปลี่ยน |
| ... | ... | ... | ... | ... |
| 23 | IATT_VIP_ONLY | ❌ | ✅ | เฉพาะ VIP |

## Race Flags (IRACE_*)

| Bit | Name | PHP | C++ | Description |
|-----|------|-----|-----|-------------|
| 0 | IRACE_BULKAN_MAN | ✅ | ✅ | Bulkan ชาย |
| 1 | IRACE_BULKAN_WOMAN | ✅ | ✅ | Bulkan หญิง |
| ... | ... | ... | ... | ... |

## NPC Behavior Flags (P_*)

| Bit | Name | PHP | C++ | Description |
|-----|------|-----|-----|-------------|
| 0 | P_AGGRESSIVE | ✅ | ✅ | โจมตีเมื่อเห็น |
| 1 | P_MOVING | ✅ | ✅ | เคลื่อนที่ได้ |
| ... | ... | ... | ... | ... |

## Equipment Slots (WEARING_*)

| Index | Name | PHP | C++ | Description |
|-------|------|-----|-----|-------------|
| 0 | WEARING_HELMET | ✅ | ✅ | หมวก |
| 1 | WEARING_ARMOR | ✅ | ✅ | เกราะ |
| ... | ... | ... | ... | ... |

## Zones

| Index | Name | PHP | C++ | Description |
|-------|------|-----|-----|-------------|
| 0 | Dekaren | ✅ | ✅ | Starting zone |
| 1 | Dekadun | ✅ | ✅ | |
| ... | ... | ... | ... | ... |
```

### Sync Scripts

#### PHP to C++ Sync
```php
<?php
// sync_to_cpp.php
// Generate C++ header from PHP constants

require_once 'utils/item_constants.php';

$output = "// Auto-generated from PHP\n";
$output .= "// Generated: " . date('Y-m-d H:i:s') . "\n\n";

// Item flags
$output .= "// Item Attribute Flags\n";
foreach (get_defined_constants(true)['user'] as $name => $value) {
    if (strpos($name, 'IATT_') === 0) {
        $output .= sprintf("#define %-25s (1 << %d)\n", $name, log($value, 2));
    }
}

file_put_contents('generated/item_flags.h', $output);
echo "Generated item_flags.h\n";
```

#### C++ to PHP Sync
```php
<?php
// sync_from_cpp.php
// Parse C++ header and generate PHP constants

$header = file_get_contents('path/to/ItemConfig.h');

// Parse #define statements
preg_match_all('/#define\s+(\w+)\s+\(1\s*<<\s*(\d+)\)/', $header, $matches);

$output = "<?php\n";
$output .= "// Auto-generated from C++\n";
$output .= "// Generated: " . date('Y-m-d H:i:s') . "\n\n";

foreach ($matches[1] as $i => $name) {
    $bit = $matches[2][$i];
    $value = 1 << $bit;
    $output .= "define('$name', $value);\n";
}

file_put_contents('utils/item_constants_generated.php', $output);
echo "Generated item_constants_generated.php\n";
```

## Validation Rules

### Bitwise Flags
```php
// ตรวจสอบว่าไม่มี bit ซ้ำกัน
function validateFlags($constants) {
    $usedBits = [];
    foreach ($constants as $name => $value) {
        $bit = log($value, 2);
        if (isset($usedBits[$bit])) {
            echo "⚠️ Duplicate bit $bit: $name and {$usedBits[$bit]}\n";
        }
        $usedBits[$bit] = $name;
    }
}
```

### Range Check
```php
// ตรวจสอบว่าอยู่ใน range ที่ถูกต้อง
function validateRange($value, $min, $max, $name) {
    if ($value < $min || $value > $max) {
        echo "⚠️ $name out of range: $value (expected $min-$max)\n";
    }
}
```

## ตัวอย่างการใช้งาน

```
/sync check          # ตรวจสอบความแตกต่าง
/sync php-to-cpp     # สร้าง C++ header จาก PHP
/sync cpp-to-php     # สร้าง PHP จาก C++ header
/sync report         # รายงานเต็ม
```

## Important Constants to Sync

### Critical (ต้อง sync เสมอ)
- Item attribute flags (IATT_*)
- Race flags (IRACE_*)
- Equipment slots (WEARING_*)
- Item types

### Important (ควร sync)
- NPC flags (P_*)
- Zone indices
- Skill IDs
- Quest IDs

### Nice to have
- Color codes
- UI constants
- Animation IDs

## Notes
- Backup ก่อน sync เสมอ
- Test ใน dev environment ก่อน
- Document changes ใน changelog
- แจ้ง team เมื่อ sync
