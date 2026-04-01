---
description: สร้างโครงสร้างใหม่ - สร้าง API, Component, Service หรือ Module
argument-hint: <ชื่อ feature> [ประเภท: api|component|service|module]
---

# Smart Scaffolding

สร้างโครงสร้างสำหรับ: $ARGUMENTS

## Scaffold Types

### API Endpoint
```
src/
├── controllers/
│   └── {name}.controller.ts
├── services/
│   └── {name}.service.ts
├── repositories/
│   └── {name}.repository.ts
├── dtos/
│   ├── create-{name}.dto.ts
│   └── update-{name}.dto.ts
├── types/
│   └── {name}.types.ts
└── tests/
    ├── {name}.controller.test.ts
    └── {name}.service.test.ts
```

### React Component
```
src/components/{Name}/
├── {Name}.tsx
├── {Name}.styles.ts
├── {Name}.types.ts
├── {Name}.test.tsx
├── use{Name}.ts (custom hook)
└── index.ts
```

### Service Module
```
src/services/{name}/
├── {name}.service.ts
├── {name}.types.ts
├── {name}.constants.ts
├── {name}.utils.ts
├── {name}.test.ts
└── index.ts
```

### Full Module
```
src/modules/{name}/
├── controllers/
├── services/
├── repositories/
├── dtos/
├── types/
├── utils/
├── tests/
├── {name}.module.ts
└── index.ts
```

## Templates Include

### Controller
- CRUD endpoints
- Input validation
- Error handling
- Authentication guards

### Service
- Business logic
- Transaction management
- Error handling
- Logging

### Repository
- Database operations
- Query optimization
- Soft delete support

### DTOs
- Validation decorators
- Type definitions
- Transform decorators

### Tests
- Unit tests
- Integration tests
- Mock factories

## Standards Applied
- TypeScript strict mode
- Proper error handling
- Input validation
- Type safety
- Documentation
- Thai comments
