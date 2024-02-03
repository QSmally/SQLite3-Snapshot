#!/bin/sh

set -e

log() {
    echo "$(date) - $1"
}

snapshot() {
    sqlite3 "$1" ".backup \"$2\""
}

if [ -z "$CELLAR" ]; then
    log "attempted to perform snapshot, but CELLAR is empty"
    exit 1
fi

backup_dir="/backups/$(date +'%d-%m-%Y')"

log "performing snapshot ($backup_dir)..."

if [ -d "$backup_dir" ]; then
    log "warning: directory exists, files may be overwritten"
fi

mkdir -p "$backup_dir"

for database in ${CELLAR//,/ }; do
    filename=$(basename "$database")
    destination="$backup_dir/$filename"
    log "$database ($filename) -> $destination"
    snapshot "$database" "$destination"
done

log "done"
