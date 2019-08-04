# AWS caching

Cache a database to an s3 bucket every 5 minutes and warm the sqlite db cache
from an s3 backup each time a new instance is launched.  This uses an AWS
cloudformation template and AutoScaling group to ensure 1 ec2 instance is
always running.
