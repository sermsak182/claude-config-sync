---
description: สร้างเทสต์ - สร้าง Unit Test, Integration Test หรือ E2E Test
argument-hint: <ไฟล์> [ประเภท: unit|integration|e2e]
---

# Generate Tests - สร้าง test cases

## คำสั่ง
```
/test <file path> [type: unit|integration|e2e]
```

## หน้าที่
สร้าง test cases สำหรับ code ที่ระบุ

## Test Types

### unit - Unit Tests
- Test individual functions
- Mock dependencies
- Fast execution

### integration - Integration Tests
- Test multiple components
- Real database (test)
- API endpoints

### e2e - End-to-End Tests
- Full user flows
- Browser automation
- Complete scenarios

## Test Structure

### PHP (PHPUnit)
```php
class ItemServiceTest extends TestCase
{
    public function testGetItemById_ValidId_ReturnsItem()
    {
        // Arrange
        $itemId = 1;

        // Act
        $result = $this->service->getItem($itemId);

        // Assert
        $this->assertNotNull($result);
        $this->assertEquals($itemId, $result['a_index']);
    }

    public function testGetItemById_InvalidId_ReturnsNull()
    {
        // Arrange
        $itemId = -1;

        // Act
        $result = $this->service->getItem($itemId);

        // Assert
        $this->assertNull($result);
    }
}
```

### JavaScript (Jest)
```javascript
describe('ItemService', () => {
    describe('getItem', () => {
        it('should return item when valid id', async () => {
            const result = await itemService.getItem(1);
            expect(result).toBeDefined();
            expect(result.id).toBe(1);
        });

        it('should throw error when invalid id', async () => {
            await expect(itemService.getItem(-1))
                .rejects.toThrow('Item not found');
        });
    });
});
```

## Test Coverage

### What to Test
- Happy path (normal flow)
- Edge cases (boundaries)
- Error cases (failures)
- Security cases (validation)

### Naming Convention
```
test[MethodName]_[Scenario]_[ExpectedResult]
```

## Output Format

```markdown
# Test Cases: [filename]

## Test File: [test_filename]

```code
[Generated test code]
```

## Coverage
| Function | Tests | Coverage |
|----------|-------|----------|
| func1 | 3 | 100% |
| func2 | 2 | 80% |

## Run Tests
```bash
[command to run tests]
```
```

## ตัวอย่าง

```
/test utils/helpers.php unit
/test public/api/item_icon.php integration
/test public/login.php e2e
```
