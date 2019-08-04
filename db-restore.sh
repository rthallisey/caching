#!/bin/bash

DATABASE="/home/ec2-user/cache.db"
RESTORE="/home/ec2-user/restore.db"

# Expecting this file to always be there.  At least on the AMI
rm "${DATABASE}"

aws s3 cp s3://cache-sqlite/db_backup.db "${RESTORE}"

# TODO:  Need some retry logic here.  We want to do the best we can to guartunee the cache is warm.

sqlite3 "${DATABASE}" ".read ${RESTORE}"

# TODO:  Validation for new data loaded.
