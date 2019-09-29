chez := scheme

problem-specifications := git@github.com:exercism/problem-specifications.git

doc-files := \
	about \
	installation \
	resources \
	tests

implementations := \
	hello-world \
	leap \
	hamming \
	atbash-cipher \
	grains \
	anagram \
	pascals-triangle \
	rna-transcription \
	difference-of-squares \
	nucleotide-count

track-documentation := $(foreach doc,$(doc-files),docs/$(doc).md)

exercisms := $(foreach exercism,$(implementations),exercises/$(exercism))

track-requirements := \
	../problem-specifications \
	bin/configlet \
	config.json \
	code/stub-makefile \
	$(track-documentation) \
	$(exercisms)

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

# exercises
exercises/% : load.ss code/track.ss code/exercises/%/* code/stub-makefile
	echo "(make-exercism '$(@F))" | $(chez) -q $<

# build track
track : $(track-requirements)
	./bin/configlet generate .
	./bin/configlet fmt .
	./bin/configlet lint .

clean :
	find . -name "*.so" -exec rm {} \;
	find . -name "*~" -exec rm {} \;
	find . -name "*.html" -exec rm {} \;
	rm -rf _build

.PHONY : track clean

