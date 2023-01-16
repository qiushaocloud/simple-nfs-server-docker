.PHONY: build

REGISTRY_URL = qiushaocloud/simple-nfs-server
VERSION = latest

build:
	docker build -t $(REGISTRY_URL):$(VERSION)

clean:
	docker image rm $(REGISTRY_URL):$(VERSION)

bash:
	docker run --rm  -it $(REGISTRY_URL) bash

deploy:
	docker push $(REGISTRY_URL):$(VERSION)
