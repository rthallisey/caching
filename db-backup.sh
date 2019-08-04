#!/bin/bash

BACKUP="/tmp/db_backup.db"

sqlite3 /home/ec2-user/cache.db ".dump" > "${BACKUP}"

# TODO: Use some filtering of the event_count value to find the most commonly used values.
#       We could make some "educated guesses" that the higher the event_count the more likely
#       a value will be used in the future.  Could filter for the top 10,000 events and store
#       them to the s3 backup as "priority-backup" in order to load them first to warm the cache.
#
#       Look at Linux kernel in memory caching techniques/algorithms in order to optimize.

aws s3 cp "${BACKUP}" s3://cache-sqlite
