---
description: จัดการ Backup - สร้าง script สำรองข้อมูล
argument-hint: [type: db|files|full|restore]
---

# Backup Manager - สร้าง backup scripts

## คำสั่ง
```
/backup [type: db|files|full|restore]
```

## หน้าที่
สร้าง backup scripts สำหรับ database และ files พร้อม restore procedures

## Backup Types

### 1. Database Backup
```
/backup db
```

### 2. Files Backup
```
/backup files
```

### 3. Full Backup (DB + Files)
```
/backup full
```

### 4. Restore Procedures
```
/backup restore
```

## Output Format

### Database Backup Script

```bash
#!/bin/bash
# backup_db.sh - Database Backup Script
# Usage: ./backup_db.sh [database_name]

# Configuration
DB_HOST="${DB_HOST:-localhost}"
DB_PORT="${DB_PORT:-3306}"
DB_USER="${DB_USER:-root}"
DB_PASS="${DB_PASS}"
BACKUP_DIR="./backups/db"
RETENTION_DAYS=30

# Databases to backup (Laghaim)
DATABASES=(
    "neogeo_web"
    "kor_ndev_neogeo_char"
    "kor_ndev_neogeo_data"
    "kor_ndev_neogeo_user"
)

# Create backup directory
mkdir -p "$BACKUP_DIR"

# Date format
DATE=$(date +%Y%m%d_%H%M%S)

# Backup function
backup_database() {
    local db=$1
    local file="$BACKUP_DIR/${db}_${DATE}.sql"

    echo "Backing up $db..."
    mysqldump -h "$DB_HOST" -P "$DB_PORT" -u "$DB_USER" -p"$DB_PASS" \
        --single-transaction \
        --routines \
        --triggers \
        --events \
        "$db" > "$file"

    if [ $? -eq 0 ]; then
        gzip "$file"
        echo "✅ $db backed up to ${file}.gz"
    else
        echo "❌ Failed to backup $db"
        return 1
    fi
}

# Run backup
if [ -n "$1" ]; then
    backup_database "$1"
else
    for db in "${DATABASES[@]}"; do
        backup_database "$db"
    done
fi

# Cleanup old backups
find "$BACKUP_DIR" -name "*.sql.gz" -mtime +$RETENTION_DAYS -delete
echo "🧹 Cleaned up backups older than $RETENTION_DAYS days"

echo "✅ Backup complete!"
```

### Files Backup Script

```bash
#!/bin/bash
# backup_files.sh - Files Backup Script

# Configuration
BACKUP_DIR="./backups/files"
RETENTION_DAYS=30
DATE=$(date +%Y%m%d_%H%M%S)

# Directories to backup
BACKUP_SOURCES=(
    "./config"
    "./public/assets"
    "./uploads"
)

# Exclude patterns
EXCLUDES=(
    "*.log"
    "*.tmp"
    "cache/*"
    "node_modules/*"
    "vendor/*"
)

# Create backup directory
mkdir -p "$BACKUP_DIR"

# Build exclude arguments
EXCLUDE_ARGS=""
for pattern in "${EXCLUDES[@]}"; do
    EXCLUDE_ARGS="$EXCLUDE_ARGS --exclude=$pattern"
done

# Create backup
BACKUP_FILE="$BACKUP_DIR/files_${DATE}.tar.gz"

echo "Creating backup..."
tar -czf "$BACKUP_FILE" $EXCLUDE_ARGS "${BACKUP_SOURCES[@]}"

if [ $? -eq 0 ]; then
    SIZE=$(du -h "$BACKUP_FILE" | cut -f1)
    echo "✅ Backup created: $BACKUP_FILE ($SIZE)"
else
    echo "❌ Backup failed"
    exit 1
fi

# Cleanup old backups
find "$BACKUP_DIR" -name "*.tar.gz" -mtime +$RETENTION_DAYS -delete
echo "🧹 Cleaned up backups older than $RETENTION_DAYS days"
```

### Full Backup Script

```bash
#!/bin/bash
# backup_full.sh - Full System Backup

# Load environment
source .env 2>/dev/null

DATE=$(date +%Y%m%d_%H%M%S)
BACKUP_ROOT="./backups"
BACKUP_DIR="$BACKUP_ROOT/full_${DATE}"

echo "========================================="
echo "  Full System Backup - $DATE"
echo "========================================="

# Create backup directory
mkdir -p "$BACKUP_DIR"

# 1. Database backup
echo ""
echo "📦 Step 1: Database Backup"
./scripts/backup_db.sh
cp "$BACKUP_ROOT/db"/*_${DATE:0:8}*.sql.gz "$BACKUP_DIR/" 2>/dev/null

# 2. Files backup
echo ""
echo "📁 Step 2: Files Backup"
./scripts/backup_files.sh
cp "$BACKUP_ROOT/files"/*_${DATE:0:8}*.tar.gz "$BACKUP_DIR/" 2>/dev/null

# 3. Config backup
echo ""
echo "⚙️ Step 3: Config Backup"
cp .env "$BACKUP_DIR/.env.backup" 2>/dev/null
cp -r config "$BACKUP_DIR/config_backup" 2>/dev/null

# 4. Create manifest
echo ""
echo "📋 Creating manifest..."
cat > "$BACKUP_DIR/manifest.txt" << EOF
Backup Manifest
===============
Date: $(date)
Server: $(hostname)
User: $(whoami)

Contents:
$(ls -la "$BACKUP_DIR")

Database Tables:
$(mysql -h "$DB_HOST" -u "$DB_USER" -p"$DB_PASS" -e "SHOW DATABASES;" 2>/dev/null)
EOF

# 5. Create single archive
echo ""
echo "📦 Creating final archive..."
FINAL_BACKUP="$BACKUP_ROOT/full_backup_${DATE}.tar.gz"
tar -czf "$FINAL_BACKUP" -C "$BACKUP_ROOT" "full_${DATE}"

# Cleanup temp directory
rm -rf "$BACKUP_DIR"

SIZE=$(du -h "$FINAL_BACKUP" | cut -f1)
echo ""
echo "========================================="
echo "✅ Full backup complete!"
echo "   File: $FINAL_BACKUP"
echo "   Size: $SIZE"
echo "========================================="
```

### Restore Script

```bash
#!/bin/bash
# restore.sh - Restore from Backup

# Usage
show_usage() {
    echo "Usage: ./restore.sh [type] [backup_file]"
    echo ""
    echo "Types:"
    echo "  db      Restore database"
    echo "  files   Restore files"
    echo "  full    Restore full backup"
    echo ""
    echo "Examples:"
    echo "  ./restore.sh db backups/db/neogeo_data_20240115.sql.gz"
    echo "  ./restore.sh files backups/files/files_20240115.tar.gz"
    echo "  ./restore.sh full backups/full_backup_20240115.tar.gz"
}

# Restore database
restore_db() {
    local file=$1
    local db=$2

    echo "⚠️ WARNING: This will overwrite database $db"
    read -p "Continue? (y/N) " confirm

    if [ "$confirm" != "y" ]; then
        echo "Cancelled"
        exit 0
    fi

    echo "Restoring $db from $file..."

    if [[ "$file" == *.gz ]]; then
        gunzip -c "$file" | mysql -h "$DB_HOST" -u "$DB_USER" -p"$DB_PASS" "$db"
    else
        mysql -h "$DB_HOST" -u "$DB_USER" -p"$DB_PASS" "$db" < "$file"
    fi

    if [ $? -eq 0 ]; then
        echo "✅ Database restored successfully"
    else
        echo "❌ Restore failed"
        exit 1
    fi
}

# Restore files
restore_files() {
    local file=$1
    local target=${2:-.}

    echo "⚠️ WARNING: This will overwrite files in $target"
    read -p "Continue? (y/N) " confirm

    if [ "$confirm" != "y" ]; then
        echo "Cancelled"
        exit 0
    fi

    echo "Restoring files from $file..."
    tar -xzf "$file" -C "$target"

    if [ $? -eq 0 ]; then
        echo "✅ Files restored successfully"
    else
        echo "❌ Restore failed"
        exit 1
    fi
}

# Main
case "$1" in
    db)
        restore_db "$2" "$3"
        ;;
    files)
        restore_files "$2" "$3"
        ;;
    full)
        echo "Extracting full backup..."
        tar -xzf "$2" -C /tmp
        restore_db "/tmp/full_*/db/*.sql.gz"
        restore_files "/tmp/full_*/files/*.tar.gz"
        rm -rf /tmp/full_*
        echo "✅ Full restore complete"
        ;;
    *)
        show_usage
        ;;
esac
```

## Cron Schedule

```bash
# crontab -e

# Daily database backup at 2 AM
0 2 * * * /path/to/backup_db.sh >> /var/log/backup_db.log 2>&1

# Weekly full backup on Sunday at 3 AM
0 3 * * 0 /path/to/backup_full.sh >> /var/log/backup_full.log 2>&1

# Monthly cleanup
0 4 1 * * find /path/to/backups -mtime +90 -delete
```

## ตัวอย่างการใช้งาน

```
/backup db        # Database backup script
/backup files     # Files backup script
/backup full      # Full backup script
/backup restore   # Restore procedures
```

## Notes
- ทดสอบ restore เป็นประจำ
- เก็บ backup ไว้หลายที่ (offsite)
- Encrypt sensitive backups
- ตั้ง retention policy
- Monitor backup success/failure
