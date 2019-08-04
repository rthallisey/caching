# AWS caching

Cache a database to an s3 bucket every 5 minutes and warm the sqlite db cache
from an s3 backup each time a new instance is launched.  This uses an AWS
cloudformation template and AutoScaling group to ensure 1 ec2 instance is
always running.

## Deploy
**NOTE:**
AWS' AutoScaling cloud-init doesn't seem to be where I thought it was
in the CloudFormation template.  The below lines need to be added wherever
cloud-init gets executed to 1) Warm the database cache by restoring it from an
s3 backup and 2) setup a cronjob to backup to s3 every 5 minutes.

```bash
             ...
             "/home/ec2-user/db-restore.sh\n",
             "cronjob /home/ec2-user/backup-cronjob\n",
             ...
```

#### Deploy Without Cloud-init
Since none of the scripts added to the CloudFormation template are appearing
on the instance, you can copy them over and run them to get a similar effect to
what cloud-init would do.

```bash
scp -i <my-key> -r ~/.aws ec2-user@<instance-dns-name>:~/
scp -i <my-key> db-backup.sh ec2-user@<instance-dns-name>:~/
scp -i <my-key> db-restore.sh ec2-user@<instance-dns-name>:~/
scp -i <my-key> cronjob ec2-user@<instance-dns-name>:~/
```

ssh to the instance, then run:
```bash
./db-restore.sh
crontab cronjob
```

#### With Cloud-init
With the above files added to cloud-init, deploy with:
```bash
make run Key_NAME=<ssh-keypair> ACCESS_KEY=<access_key> SECRET_ACCESS_KEY=<secret_access_key>
```
