#!/bin/bash

# Script to -if necessary- create on host persistent directories and start the docker compose services

# Directory needed for storing persistently Postgres database on host.
# Directory will be created on host only if inexistent.
# Docker Compose will create this directory via volume definition.
DBDIR=postgresql/postgres_database
if [ ! -d "$DBDIR" ]; then
    echo "Directory \"$DBDIR\" does not exist. It must be created."
    echo "Create directory \"$DBDIR\""
    mkdir $DBDIR
else
    echo "Directory \"$DBDIR\" exists already: no need to create it"
fi

# Backup directory for storing the Postgres backup file on host.
# Directory will be created on host only if inexistent.
# Docker Compose will create this directory via volume definition.
# The name of the backup file must be "seed.backup" as defined in Docker Compose.
BACKUPDIR=postgresql/postgres_backups
if [ ! -d "$BACKUPDIR" ]; then
    echo "Directory \"$BACKUPDIR\" does not exist. It must be created."
    echo "Create directory \"$BACKUPDIR\""
    mkdir $BACKUPDIR
    chmod 777 $BACKUPDIR
else
    echo "Directory \"$BACKUPDIR\" exists already: no need to create it"
fi

# Directory needed for storing persistently ZK container files on host.
# Directory will be created only if inexistent.
# Docker Compose will create this directory via volume definition.
PERSISTENTDIR=postgresql/persistent_files
if [ ! -d "$PERSISTENTDIR" ]; then
    echo "Directory \"$PERSISTENTDIR\" does not exist. It must be created."
    echo "Create directory \"$PERSISTENTDIR\""
    mkdir $PERSISTENTDIR
    chmod 777 $PERSISTENTDIR
else
    echo "Directory \"$PERSISTENTDIR\" exists already: no need to create it"
fi

cp env_template .env
docker compose up -d
