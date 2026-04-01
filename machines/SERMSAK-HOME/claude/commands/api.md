---
description: สร้าง API - สร้าง REST API endpoints พร้อม CRUD
argument-hint: <ชื่อ resource> [ประเภท: crud|read|custom]
---

# API Endpoint Generator

สร้าง API endpoint สำหรับ: $ARGUMENTS

## API Design Principles:

### 1. RESTful Standards
- ใช้ HTTP methods ถูกต้อง (GET, POST, PUT, PATCH, DELETE)
- Resource-based URLs
- Proper status codes
- HATEOAS (ถ้าเหมาะสม)

### 2. Request Handling
- Input validation ทุก field
- Type checking
- Required/optional fields
- Default values
- Sanitization

### 3. Response Format
```json
{
  "success": true,
  "data": {},
  "message": "string",
  "errors": [],
  "meta": {
    "pagination": {}
  }
}
```

### 4. Error Handling
- Consistent error format
- Meaningful error messages
- Error codes
- Stack trace (dev only)

### 5. Security
- Authentication middleware
- Authorization checks
- Rate limiting
- Input sanitization
- SQL injection prevention

### 6. Documentation
- OpenAPI/Swagger spec
- Request/Response examples
- Error codes documentation

## Output ที่สร้าง:

### 1. Route Definition
```javascript
// Express/Fastify/Hono route
router.post('/resource', controller.create);
```

### 2. Controller
- Request parsing
- Business logic call
- Response formatting

### 3. Validation Schema
```javascript
// Zod/Joi/Yup schema
const schema = z.object({...});
```

### 4. Service Layer
- Business logic
- Database operations
- External API calls

### 5. Types/Interfaces
```typescript
interface CreateResourceDTO {...}
interface ResourceResponse {...}
```

### 6. Tests
- Unit tests for controller
- Integration tests for endpoint
- Edge cases

### 7. Documentation
- Swagger/OpenAPI spec
- Example requests/responses
