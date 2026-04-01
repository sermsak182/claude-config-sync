---
description: จัดการฐานข้อมูล - สร้าง รัน และย้อนกลับ migrations
argument-hint: <คำสั่ง: create|run|rollback|status> [ชื่อ]
---

# Database Migration Helper

จัดการ migrations สำหรับ: $ARGUMENTS

## Actions

### create <name>
สร้าง migration file ใหม่
```bash
# ตัวอย่าง
/migrate create add_users_table
/migrate create add_email_to_users
/migrate create create_orders_table
```

### run
รัน pending migrations ทั้งหมด

### rollback [steps]
ย้อนกลับ migration (default: 1 step)

### status
แสดงสถานะ migrations ทั้งหมด

## Migration Template

```typescript
import { Migration } from './types';

export const migration: Migration = {
  name: 'YYYYMMDDHHMMSS_migration_name',

  async up(db) {
    // สร้าง/แก้ไข schema
    await db.schema.createTable('table_name', (table) => {
      table.increments('id').primary();
      table.string('name').notNullable();
      table.timestamps(true, true);
    });
  },

  async down(db) {
    // ย้อนกลับ (rollback)
    await db.schema.dropTableIfExists('table_name');
  }
};
```

## Best Practices

### DO
- ✅ ตั้งชื่อ descriptive
- ✅ มี down() เสมอ
- ✅ ใช้ transactions
- ✅ Test rollback ก่อน deploy
- ✅ Backup ก่อน run production

### DON'T
- ❌ แก้ไข migration ที่ run แล้ว
- ❌ ลบ migration files
- ❌ ใส่ business logic
- ❌ Seed data ใน migration

## Output

```markdown
## Migration: {name}

### Up Migration
[SQL/code ที่จะรัน]

### Down Migration
[SQL/code สำหรับ rollback]

### Affected Tables
- table1: [changes]
- table2: [changes]

### Warnings
[ถ้ามี breaking changes]
```
