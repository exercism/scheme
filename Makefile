chez := scheme

problem-specifications := git@github.com:exercism/problem-specifications.git

doc-files := about installation resources tests
track-documentation := $(foreach doc,$(doc-files),docs/$(doc).md)



default : track

# exercism/problem-specifications repo
../problem-specifications :
	cd .. && git clone $(problem-specifications)

# configlet binary
bin/configlet :
	./bin/fetch-configlet

# configuration
config.json : load.ss code/config.ss
	echo "(make-config)" | $(chez) -q $<

# documentation
docs/%.md : load.ss code/track.ss code/sxml.sls code/docs/%.ss
	echo "(put-md '$(@F:.md=))" | $(chez) -q $<

# generate problems
build : load.ss ../problem-specifications
	echo "(build-implementations)" | $(chez) -q $<

# test problems
test : load.ss
	echo "(verify-implementations)" | $(chez) -q $<

# build whole track
track : ../problem-specifications config.json bin/configlet $(track-documentation) test
	./bin/configlet generate .
	./bin/configlet fmt .
	./bin/configlet lint .

clean :
	find . -name "*.so" -exec rm {} \;
	find . -name "*~" -exec rm {} \;
	find . -name "*.html" -exec rm {} \;
	rm -rf _build

.PHONY : track clean build test

