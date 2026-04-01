---
description: สร้างโปรเจคใหม่ - สร้างจาก template สำเร็จรูป
argument-hint: <project-name> [type: php-api|php-admin|node|python]
---

# New Project Generator

สร้างโปรเจคใหม่จาก template: $ARGUMENTS

## Available Templates:

### 1. nodejs-api
Node.js API with Express/Fastify + TypeScript + Prisma
```bash
/new nodejs-api my-project-name
```

### 2. laravel-api
Laravel 11 API with Sanctum + Repository Pattern
```bash
/new laravel-api my-project-name
```

### 3. fastapi
FastAPI with SQLAlchemy 2.0 + Pydantic v2
```bash
/new fastapi my-project-name
```

## กระบวนการ:

1. **Parse Arguments**
   - ระบุ template ที่ต้องการ
   - ระบุชื่อโปรเจค

2. **Generate Structure**
   - สร้าง folder structure ตาม template
   - สร้างไฟล์ core ทั้งหมด

3. **Configure**
   - ตั้งค่า package.json / composer.json / pyproject.toml
   - สร้าง .env.example
   - สร้าง Docker files

4. **Initialize**
   - git init
   - Install dependencies (optional)

## Output:
สร้างโปรเจคพร้อมใช้งานใน directory ที่ระบุ พร้อม:
- โครงสร้างไฟล์ครบ
- Configuration files
- Docker setup
- README.md
- .gitignore
