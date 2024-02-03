
# SQLite3-Snapshot

Image to periodically backup SQLite3 databases.

An `alpine` image which runs a Crontab to take snapshots of the comma-separated `CELLAR` environment
variable, putting the output in the volume bound to `/backup`. See `default` to modify the frequency
of the snapshots. In the future, a weekly archive may be added.

## Usage

A compose service may look something like the following, running it with `$ docker compose up`.

```yml
services:
  snapshots:
    restart: always
    build: SQLite3-Snapshot/ # Dockerfile, snapshot.sh
    container_name: snapshots
    volumes:
      - "./Cellar:/Cellar"
      - "./Snapshots:/backups" # must be /backups
      - "./SQLite3-Snapshot/default:/etc/crontabs/root" # schedule
    environment:
      - "CELLAR=/Cellar/foo.sqlite,/Cellar/bar.sqlite" # comma separated files
```
