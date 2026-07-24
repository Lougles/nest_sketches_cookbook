#!/bin/bash

DB_HOST="localhost"
DB_PORT="5432"
DB_USER="{{ db_user }}"
DB_PASSWORD="{{ db_password }}"
DB_NAME="{{ db_name }}"
BACKUP_DIR="/var/www/{{ project_name }}/current/backup"
DATE=$(date +"%Y%m%d%H%M")
BACKUP_FILE="$BACKUP_DIR/$DB_NAME-backup-$DATE.sql.gz"

mkdir -p $BACKUP_DIR

export PGPASSWORD=$DB_PASSWORD

pg_dump -h $DB_HOST -p $DB_PORT -U $DB_USER $DB_NAME | gzip > $BACKUP_FILE

if [ $? -eq 0 ]; then
  echo "($DATE) Database backup has been created successfully: $BACKUP_FILE"
else
  echo "($DATE) An error occurred while creating database backup" >&2
  exit 1
fi

find $BACKUP_DIR -type f -name "*.sql.gz" -mtime +3 -exec rm {} \;
