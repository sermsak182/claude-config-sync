---
description: ออกแบบฐานข้อมูล - สร้าง schema และวิเคราะห์ตาราง
argument-hint: <ชื่อตารางหรือคำสั่ง>
---

# Database Schema Designer

ออกแบบ database schema สำหรับ: $ARGUMENTS

## Design Process:

### 1. Requirements Analysis
- ระบุ entities ที่ต้องการ
- ระบุ relationships (1:1, 1:N, M:N)
- ระบุ attributes ของแต่ละ entity
- ระบุ constraints และ business rules

### 2. Normalization
- 1NF: Atomic values
- 2NF: No partial dependencies
- 3NF: No transitive dependencies
- Denormalize เฉพาะที่จำเป็น (performance)

### 3. Data Types
- เลือก types ที่เหมาะสม
- ขนาดที่เหมาะสม (VARCHAR length)
- Nullable vs NOT NULL
- Default values

### 4. Indexing Strategy
- Primary keys
- Foreign keys
- Composite indexes
- Covering indexes
- Full-text indexes (ถ้าจำเป็น)

### 5. Performance Considerations
- Partitioning strategy
- Sharding considerations
- Query patterns
- Read/Write ratio

## Output ที่สร้าง:

### 1. ERD (Entity Relationship Diagram)
```
[User] 1--N [Order] N--M [Product]
```

### 2. SQL Schema
```sql
CREATE TABLE users (
  id BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  email VARCHAR(255) NOT NULL UNIQUE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  INDEX idx_email (email)
);
```

### 3. Migration Files
- สำหรับ framework ที่ใช้ (Knex, Prisma, Laravel, Alembic)
- Up และ Down migrations
- Seed data (ถ้าจำเป็น)

### 4. Model/Entity Classes
```typescript
// Prisma, TypeORM, Sequelize, Eloquent
class User {
  id: number;
  email: string;
}
```

### 5. Relationships
```typescript
// hasMany, belongsTo, manyToMany
User.hasMany(Order);
Order.belongsTo(User);
```

### 6. Indexes Recommendation
- ระบุ indexes ที่ควรสร้าง
- อธิบายเหตุผล
- Query patterns ที่รองรับ

### 7. Query Examples
- CRUD operations
- Complex queries
- Aggregations
