CONFIGLET := bin/configlet

.DEFAULT_GOAL := track

$(CONFIGLET):
	./bin/fetch-configlet

track: $(CONFIGLET)
	$(CONFIGLET) --track-dir . lint

fmt: $(CONFIGLET)
	$(CONFIGLET) --track-dir . fmt --update --yes

ci:
	./script/ci.sh

clean:
	find exercises -name '*.so' -delete
	find exercises -name '*~' -delete

.PHONY: track fmt ci clean
