# AWS caching

Cache a database to an s3 bucket every 5 minutes and warm the sqlite db cache
from an s3 backup each time a new instance is launched.  This uses an AWS
cloudformation template and AutoScaling group to ensure 1 ec2 instance is
always running.

**NOTE:**
AWS' AutoScaling cloud-init doesn't seem to be where I thought it was
in the CloudFormation template.  The below commands need to be added wherever
cloud-init gets executed to 1) Warm the database cache by restoring it from an
s3 backup and 2) setup a cronjob to backup to s3 every 5 minutes.

```bash
             ...
             "/home/ec2-user/db-restore.sh\n",
             "cronjob /home/ec2-user/backup-cronjob\n",
             ...
```
