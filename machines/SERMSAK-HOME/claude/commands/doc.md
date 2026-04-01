---
description: สร้างเอกสาร - สร้าง API docs, README, JSDoc อัตโนมัติ
argument-hint: <ไฟล์หรือโฟลเดอร์> [ประเภท: api|readme|jsdoc|all]
---

# Smart Documentation Generator

สร้าง documentation สำหรับ: $ARGUMENTS

## Documentation Types

### API Documentation
- Endpoint descriptions
- Request/Response schemas
- Authentication requirements
- Error codes
- Examples

### README
- Project overview
- Installation
- Configuration
- Usage examples
- API reference
- Contributing guide

### JSDoc/TSDoc
- Function documentation
- Parameter descriptions
- Return types
- Examples
- Throws documentation

### All
- Generate ทุก type ด้านบน

## API Doc Template

```markdown
## {Method} {Path}

{Description}

### Authentication
{Required/Optional} - {Type}

### Request

#### Headers
| Header | Required | Description |
|--------|----------|-------------|
| ...    | ...      | ...         |

#### Parameters
| Param | Type | Required | Description |
|-------|------|----------|-------------|
| ...   | ...  | ...      | ...         |

#### Body
```json
{
  "field": "type - description"
}
```

### Response

#### Success (200)
```json
{
  "success": true,
  "data": {}
}
```

#### Error (4xx/5xx)
```json
{
  "success": false,
  "error": {
    "code": "ERROR_CODE",
    "message": "description"
  }
}
```

### Examples

#### cURL
```bash
curl -X {METHOD} ...
```

#### JavaScript
```javascript
const response = await fetch(...)
```
```

## JSDoc Template

```typescript
/**
 * {Brief description}
 *
 * {Detailed description if needed}
 *
 * @param {Type} name - Description
 * @returns {Type} Description
 * @throws {ErrorType} When condition
 *
 * @example
 * // Example usage
 * const result = functionName(param);
 */
```

## Output Formats
- Markdown (.md)
- OpenAPI/Swagger (.yaml)
- TypeDoc
- Inline comments
