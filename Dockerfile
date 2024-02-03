
FROM alpine

RUN apk update && apk add sqlite

COPY snapshot.sh /

VOLUME /etc/crontabs/root
VOLUME /backups

CMD ["crond", "-f"]
