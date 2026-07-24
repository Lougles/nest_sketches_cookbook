#!/bin/bash
BACKUP_DIR="/var/www/{{ project_name }}/current/backup"
find $BACKUP_DIR -type f -name "*.sql.gz" -mtime +7 -exec rm {} \;
