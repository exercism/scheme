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
	nucleotide-count \
	scrabble-score \
	two-fer \
	word-count \
	knapsack \
	raindrops \
	phone-number \
	prime-factors \
	transpose \
	rotational-cipher

track-documentation := $(foreach doc,$(doc-files),docs/$(doc).md)

exercisms := $(foreach exercism,$(implementations),exercises/$(exercism))

readme-splice := config/exercise-readme-insert.md

track-requirements := \
	../problem-specifications \
	bin/configlet \
	config.json \
	code/stub-makefile \
	$(readme-splice) \
	$(exercisms)

# run given expression after loading load.ss
exercise = echo $(1) | $(chez) -q load.ss

default : track

# exercism/problem-specifications repo
../problem-specifications :
	cd .. && git clone $(problem-specifications)

# configlet binary
bin/configlet :
	./bin/fetch-configlet

# configuration
config.json : code/config.ss
	$(call exercise, "(make-config)")

# documentation
docs/%.md : code/md.ss code/docs/%.ss
	$(call exercise, "(put-doc '$(@F:.md=))")

$(readme-splice) : $(track-documentation)
	cp docs/TESTS.md $@

# exercises
exercises/% : code/md.ss code/test.ss code/track.ss code/exercises/%/* code/stub-makefile code/docs/tests.ss
	$(call exercise, "(make-exercism '$(@F))")

# build track
track : $(track-requirements)
	./bin/configlet generate .
	./bin/configlet lint .

clean :
	find . -name "*.so" -exec rm {} \;
	find . -name "*~" -exec rm {} \;
	find . -name "*.html" -exec rm {} \;
	rm -rf _build

.PHONY : track clean

