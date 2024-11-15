#!/bin/bash

#--------------------------copia incremental--------------------------
BACKUP_DIR="/home/client/Escritorio/backups"
SOURCE_DIR="/opt/lampp/htdocs/"
BACKUP_FILE="$BACKUP_DIR/$(basename $SOURCE_DIR)_$(date +'%Y-%m-%d_%H-%M-%S').tar.gz"

tar -czf "$BACKUP_FILE" -C "$SOURCE_DIR" .

if [ $? -eq 0 ]; then
    echo "Copia incremental realizada con éxito."
else
    echo "Hubo un error en la copia."
    exit 1
fi

#--------------------------copia hacia la carpeta github--------------------------
cd /home/client/Escritorio/backups/
cp "$(ls -t /home/client/Escritorio/backups/ | head -n 1)" /home/client/Escritorio/github/Backup_CHS/

#--------------------------subida a github--------------------------
cd /home/client/Escritorio/github/Backup_CHS/
git add .
git commit -m "Backup automático: $(date +'%Y-%m-%d %H:%M:%S')"
git push origin main

#--------------------------limpiar y finalizar--------------------------
rm -r /home/client/Escritorio/backups/*
echo "Backup completo y subido exitosamente a GitHub."
