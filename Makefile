APPLICATION_ENVIRONMENT ?= test
HEROKU_APP ?= fixme
JQ = $(shell which jq)
COLLECTION_ROOT = $(APPLICATION)/data/collections/collection-root

%.plan: init
	terraform plan -out $@

init:
	terraform $@



default: extract



extract: $(COLLECTION_ROOT)/user/$(DOMAIN)/.Radicale.props



$(COLLECTION_ROOT):
	mkdir -p $@



$(COLLECTION_ROOT)/user/%/.Radicale.props: $(COLLECTION_ROOT)
	rm -f $@
	mkdir -p `dirname $@`
	$(JQ) -nc  --arg name $(DOMAIN) --arg desc $(DOMAIN) --arg color '#000000' -f `basename $@`.jq > $@



build:
	docker build -t radical:latest .

run: build
	docker run --rm -p 5432:5432 radical:latest

.PHONY: image.pkr.hcl

image.pkr.hcl:
	packer build $@


$(APPLICATION_ENVIRONMENT)/bookmarks-%.json:
	@cat $@ | jq -rf bookmarks.jq
