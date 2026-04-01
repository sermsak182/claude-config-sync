---
description: ปรับปรุงประสิทธิภาพ - วิเคราะห์และเพิ่มความเร็วของโค้ด
argument-hint: <ไฟล์หรือโฟลเดอร์>
---

# Performance Optimizer

วิเคราะห์และปรับปรุง performance สำหรับ: $ARGUMENTS

## Analysis Areas

### 1. Algorithm Complexity
- Time complexity (Big O)
- Space complexity
- Identify O(n²) or worse
- Suggest optimizations

### 2. Database Performance
- Query analysis
- N+1 detection
- Missing indexes
- Query optimization
- Connection pooling

### 3. Memory Usage
- Memory leaks
- Large object retention
- Unnecessary copies
- Buffer management

### 4. Network/I/O
- Unnecessary requests
- Batch opportunities
- Caching potential
- Compression

### 5. Frontend (if applicable)
- Bundle size
- Render performance
- Lazy loading
- Code splitting

## Optimization Techniques

### Caching
```typescript
// Memory cache
const cache = new Map();

// Redis cache
await redis.setex(key, ttl, value);

// HTTP cache headers
res.setHeader('Cache-Control', 'max-age=3600');
```

### Database
```sql
-- Add indexes
CREATE INDEX idx_user_email ON users(email);

-- Optimize queries
SELECT * FROM orders WHERE user_id = ? LIMIT 100;

-- Use explain
EXPLAIN ANALYZE SELECT ...
```

### Code Optimization
```typescript
// ❌ Bad: O(n²)
array.forEach(a => array.filter(b => b.id === a.id));

// ✅ Good: O(n)
const map = new Map(array.map(x => [x.id, x]));
array.forEach(a => map.get(a.id));
```

## Output

```markdown
## Performance Report

### Summary
- Current bottlenecks
- Estimated improvement
- Priority ranking

### Findings

#### 🔴 Critical (>50% improvement possible)
| Issue | Location | Current | Optimized | Improvement |
|-------|----------|---------|-----------|-------------|
| ...   | ...      | O(n²)   | O(n log n)| 10x faster  |

#### 🟡 Medium (10-50% improvement)
...

#### 🟢 Minor (<10% improvement)
...

### Recommendations
1. [Quick wins - แก้ได้เลย]
2. [Medium effort - ต้องวางแผน]
3. [Major refactor - ต้องคุย]

### Benchmarks
Before: X ms/op
After: Y ms/op
Improvement: Z%
```
