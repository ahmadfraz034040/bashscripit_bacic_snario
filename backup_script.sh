#!/bin/bash

SOURCE_DIR="/home/ubuntu/important1_data"
BACKUP_DIR="/home/ubuntu/backup_directory"

# Create directories
mkdir -p "$SOURCE_DIR"
mkdir -p "$BACKUP_DIR"

# Create sample files
echo "file 1 has been added" > "$SOURCE_DIR/file1.txt"
echo "file 2 has been added" > "$SOURCE_DIR/file2.txt"

# Backup files
cp -r "$SOURCE_DIR"/. "$BACKUP_DIR"/

echo "Backup complete successfully"
