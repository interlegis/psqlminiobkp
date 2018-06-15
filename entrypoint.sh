#! /bin/bash
set -e -o pipefail

DB="$1"
ARGS="${@:2}"

mc config host add pg "$MINIO_SERVER" "$MINIO_ACCESS_KEY" "$MINIO_SECRET_KEY" "$MINIO_API_VERSION" > /dev/null

ARCHIVE="${MINIO_BUCKET}/${DB}-$(date $DATE_FORMAT).archive"

echo "Dumping $DB to $ARCHIVE"
echo "> pg_dump ${ARGS} -Fc $DB"

pg_dump $ARGS -Fc "$DB" | mc pipe "pg/$ARCHIVE" || { echo "Backup failed"; mc rm "pg/$ARCHIVE"; exit 1; }

echo "Removing files older than ${KEEP_DAYS} days..."
mc rm --force --older-than=${KEEP_DAYS} ${MINIO_BUCKET} || { echo "ERROR removing files older than ${KEEP_DAYS} days." }

echo "Backup complete"
