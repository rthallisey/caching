ACCESS_KEY          ?=
SECRET_ACCESS_KEY   ?=
KEY_NAME            ?=

run:
	aws cloudformation deploy --template-file cloudformation.template --stack-name caching --parameter-overrides KeyName=$(KEY_NAME) AccessKey=$(ACCESS_KEY) SecretAccessKey=$(SECRET_ACCESS_KEY)

.PHONY: run
