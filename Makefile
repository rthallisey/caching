run:
	aws cloudformation deploy --template-file cloudformation.template --stack-name caching --parameter-overrides KeyName=<key-pair> AccessKey=<access-key> SecretAccessKey=<secret-access-key>
