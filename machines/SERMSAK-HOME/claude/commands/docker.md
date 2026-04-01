---
description: สร้าง Docker - สร้าง Dockerfile และ docker-compose
argument-hint: [ประเภท: dev|prod|full]
---

# Docker Configuration Generator

สร้าง Docker configuration สำหรับ: $ARGUMENTS

## Docker Best Practices:

### 1. Dockerfile Optimization
- Multi-stage builds
- Layer caching optimization
- Minimal base images (alpine, distroless)
- Non-root user
- .dockerignore

### 2. Security
- ไม่ run as root
- Read-only filesystem (ถ้าได้)
- No secrets in image
- Scan for vulnerabilities
- Minimal packages

### 3. Performance
- Layer ordering (least changing first)
- Build cache utilization
- Small image size
- Health checks

## Output ที่สร้าง:

### 1. Dockerfile
```dockerfile
# Multi-stage build
FROM node:20-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production

FROM node:20-alpine AS runner
WORKDIR /app
RUN addgroup -g 1001 -S appgroup && \
    adduser -u 1001 -S appuser -G appgroup
COPY --from=builder /app/node_modules ./node_modules
COPY . .
USER appuser
EXPOSE 3000
HEALTHCHECK --interval=30s --timeout=3s \
  CMD wget --no-verbose --tries=1 --spider http://localhost:3000/health || exit 1
CMD ["node", "server.js"]
```

### 2. docker-compose.yml
```yaml
version: '3.8'
services:
  app:
    build: .
    ports:
      - "3000:3000"
    environment:
      - NODE_ENV=production
    depends_on:
      - db
      - redis
    restart: unless-stopped

  db:
    image: mysql:8
    volumes:
      - db_data:/var/lib/mysql
    environment:
      MYSQL_ROOT_PASSWORD_FILE: /run/secrets/db_root_password
    secrets:
      - db_root_password

  redis:
    image: redis:alpine
    volumes:
      - redis_data:/data

volumes:
  db_data:
  redis_data:

secrets:
  db_root_password:
    file: ./secrets/db_root_password.txt
```

### 3. .dockerignore
```
node_modules
.git
.env
*.log
Dockerfile
docker-compose*.yml
.dockerignore
```

### 4. docker-compose.dev.yml
- Development overrides
- Hot reload volumes
- Debug ports

### 5. docker-compose.prod.yml
- Production optimizations
- Resource limits
- Logging configuration

### 6. Scripts
```bash
# build.sh
docker build -t myapp:latest .

# run.sh
docker-compose up -d

# logs.sh
docker-compose logs -f app
```

### 7. CI/CD Integration
- GitHub Actions workflow
- Multi-arch builds
- Registry push
