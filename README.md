# psqlminiobkp
Docker container to backup a PostgreSQL database directly to Minio.

Can be used to back up databases periodically with a solution such as rancher-container-crontab. See Rancher catalog sample at https://github.com/interlegis/rancher-il-catalog/tree/master/templates/psqlminbkp

## Sample docker-compose.yml

```
version: '2'
  
services:
  miniobackup:
    image: interlegis/psqlminiobkp:latest
    environment:
      - MINIO_SERVER=https://your.minio.url
      - MINIO_ACCESS_KEY=your_access_key
      - MINIO_SECRET_KEY=your_secret_key
      - MINIO_BUCKET=postgresbkp
      - PGPASSWORD=backup_user_password
      - KEEP_DAYS=7
    command: [ "dbname", "-h", "dbhost", "-U", "backupuser"]

```

**IMPORTANT**: This image assumes the bucket is used solely for the PostgreSQL backup, and removes files older than KEEP_DAYS after every backup.

