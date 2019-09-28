problem-specifications := git@github.com:exercism/problem-specifications.git
doc-files := about installation resources tests
track-documentation := $(foreach doc,$(doc-files),docs/$(doc).md)

default : track

# ensure problem specifications is nearby
../problem-specifications :
	(cd .. && git clone $(problem-specifications))

bin/configlet :
	(./bin/fetch-configlet)

config.json : load.ss code/config.ss
	(echo "(make-config)" | scheme -q $<)

docs/%.md : load.ss code/docs/%.ss
	(echo "(put-md '$(@F:.md=))" | scheme -q $< > $@)

build : load.ss ../problem-specifications
	(echo "(build-implementations)" | scheme -q $<)

test : load.ss
	(echo "(verify-implementations)" | scheme -q $<)

track : ../problem-specifications config.json bin/configlet
	(make $(track-documentation) && make build && make test && \
	./bin/configlet generate . && ./bin/configlet fmt . && ./bin/configlet lint .)

clean :
	find . -name "*.so" -exec rm {} \;
	find . -name "*~" -exec rm {} \;
	find . -name "*.html" -exec rm {} \;
	rm -rf _build

.PHONY : track 

