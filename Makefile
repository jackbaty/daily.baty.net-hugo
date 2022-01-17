SERVER_HOST=server01.baty.net
SERVER_DIR=/home/jbaty/apps/daily.baty.net-hugo/public_html
PUBLIC_DIR=/Users/jbaty/sites/daily.baty.net-hugo/public/
TARGET=server01.baty.net

.POSIX:
.PHONY: help build checkpoint deploy


.PHONY: help
help: ## Show this help
	@egrep -h '\s##\s' 'Makefile' | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'
	@egrep -h 'h' 'Makefile' | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

build:
	hugo

checkpoint:
	git add .
	git diff-index --quiet HEAD || git commit -m "Publish checkpoint"

deploy: build checkpoint
	git push
	@echo "\033[0;32mDeploying updates to $(TARGET)...\033[0m"
	rsync -v -rz --checksum --delete --no-perms $(PUBLIC_DIR) $(SERVER_HOST):$(SERVER_DIR)

