FROM postgres:9.6.9-alpine

RUN apk update && apk add ca-certificates wget && update-ca-certificates
RUN wget -O /usr/local/bin/mc https://dl.minio.io/client/mc/release/linux-amd64/mc
RUN chmod +x /usr/local/bin/mc

ENV MINIO_SERVER="" \
    MINIO_BUCKET="backups" \
    MINIO_ACCESS_KEY="" \
    MINIO_SECRET_KEY="" \
    MINIO_API_VERSION="S3v4" \
    DATE_FORMAT="+%Y-%m-%d"

ADD entrypoint.sh /app/entrypoint.sh

ENTRYPOINT [ "/app/entrypoint.sh" ]
