JQ = $(shell which jq)
USER = admin
COLLECTION_ROOT = data/collections/collection-root

STAGE = development

include $(STAGE).mk


default: extract data/collections/.Radicale.lock

data/collections/.Radicale.lock:
	touch $@



extract: $(COLLECTION_ROOT)/$(USER)/$(DOMAIN)/.Radicale.props



$(COLLECTION_ROOT):
	mkdir -p $@



$(COLLECTION_ROOT)/$(USER)/%/.Radicale.props: $(COLLECTION_ROOT)
	@rm -f $@
	@mkdir -p `dirname $@`
	@$(JQ) -nc  --arg name $(DOMAIN) --arg desc $(DOMAIN) --arg color '#000000' -f `basename $@`.jq > $@
	$(JQ) < $@

